class PlansController < ApplicationController
  def index
  end

  def new

  end

  # def testnew
  #
  # end

  # def create
  # end

  def create
    @user = current_user
    @data = params

    new_plan = @user.plans.new(frequency: 1, topic: params['topic'], cards_per_serve: 5, serves: 5)
    new_plan.language = params['language']
    new_plan.save

    if params['topic'].length > 1
      topic = params['topic'] + '+'
    else
      topic = ''
    end
    q = "q=#{topic}language:#{params['language']} stars:>19"
    puts '***************************************************'
    puts q
    puts '***************************************************'
    @data = Octokit.search_repos(q, per_page: 100)
    @data = new_plan.create_plan(@data.items, @user)

<<<<<<< HEAD
    render json: @data
=======
    puts '*************************'
    p @data
    puts '*************************'

    redirect_to action: "show", id: new_plan.id
>>>>>>> 58119a642d0d19946083195b05bddb99d11df9cf
  end

  def show
    @plan = Plan.find_by(id: params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  # def createplan
  #   @repositories = params[:repos]
  #   @repositories.each do |repository|
  #     puts "*" * 100
  #     # fetching property example
  #     p repository[1]['full_name']
  #   end
  #   redirect_to root_path
  # end
end
