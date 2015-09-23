require 'sendgrid-ruby'

class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    client = SendGrid::Client.new(api_user: ENV['SENDGRID_USERNAME'], api_key: ENV['SENDGRID_PASSWORD'])
    mail = SendGrid::Mail.new do |m|

    m.to = 'jxu011@ucr.edu'
    m.from = 'jsnx21@gmail.com'
    m.subject = 'implementation of binary search in constant time'
    m.text = 'askldfafjkladsfjklsajflksadjfkl;sajfsdkjldkjaflkdf chacharon chacharon '
    end
    puts client.send(mail)
  end
end
