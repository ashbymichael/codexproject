require 'sendgrid-ruby'

class PlansController < ApplicationController

  def index
    @user = current_user
    @plans = @user.plans

  end

  def email
    client = SendGrid::Client.new(api_user: ENV['SENDGRID_USERNAME'], api_key: ENV['SENDGRID_PASSWORD'])
    mail = SendGrid::Mail.new do |m|

    m.to = params[:email]
    m.from = 'jxu011@ucr.com'
    m.subject = 'implementation of binary search in constant time'
    m.text = 'askldfafjkladsfjklsajflksadjfkl;sajfsdkjldkjaflkdf chacharon chacharon '
    end
    puts client.send(mail)
    redirect_to plans_path
  end

  def new

  end

  def create
      @user = current_user
      name = "#{Time.now.year}/#{Time.now.month}/#{Time.now.day} #{params['plan']['language']} #{params['plan']['topic']}"
      new_plan = @user.plans.create(frequency: 1, topic: params['plan']['topic'],
                                 cards_per_serve: 5, serves: 5, name: name,
                                 twilio: false, sendgrid: false,
                                 language: params['plan']['language'])
      if params['plan']['topic'].length > 1
        topic = params['plan']['topic'] + '+'
      else
        topic = ''
      end
      create_query(topic)
      @data = new_plan.create_plan(@data.items, @user)
      #binding.pry
      if params['plan']['twilio'] == 't'
        @message_body = "Greetings from Team Codex, #{@user.username}! Your new plan \'#{name}\' has been created. Login to check it out!"
        send_twilio_notification("+12026572604", "+12027190379", @message_body)
        p "twilio conditional hit penguins"
      end
      if params['plan']['sendgrid'] == 't'
        # loop do
        #     runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
        #     sleep 5
        # end

        client = SendGrid::Client.new(api_user: ENV['SENDGRID_USERNAME'], api_key: ENV['SENDGRID_PASSWORD'])
        mail = SendGrid::Mail.new do |m|
          m.to = params[:plan][:email]
          m.from = 'jxu011@ucr.com'
          m.subject = 'implementation of binary search in constant time'
          m.text = 'askldfafjkladsfjklsajflksadjfkl;sajfsdkjldkjaflkdf chacharon chacharon '
        end
      puts client.send(mail)
      #redirect_to plans_path
      end
      redirect_to action: "show", id: new_plan.id
  end

  def show
    @plan = Plan.find_by(id: params[:id])
  end

  def edit
    @plan = Plan.find_by(id: params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    redirect_to plan_path(@plan) if @plan.update(plan_params)
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to plans_path
  end

  private
    def create_query(topic)
      q = "#{topic}language:#{params['plan']['language']} stars:>100 pushed:>#{DateTime.now - 18.months}"
      # authenticate_github
      Octokit.auto_paginate = true
      @data = Octokit.search_repos(q, {sort: 'stars', order: 'desc'})
    end

    def plan_params
      params.require(:plan).permit(:name,:frequency,:twilio,:sendgrid, :topic)
    end
end
