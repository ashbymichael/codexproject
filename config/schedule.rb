#job_type :sendgrid_email, '/plans :task :send_email'

# every 1.hour do
#   sengrid "email", :email => "jsnx21@gmail.com"
# end
require 'sendgrid-ruby'

puts "hello"

every 1.minute do
  p ENV['SENDGRID_USERNAME']
  client = SendGrid::Client.new(api_user: ENV['SENDGRID_USERNAME'], api_key: ENV['SENDGRID_PASSWORD'])
    mail = SendGrid::Mail.new do |m|

    m.to = 'jxu011@ucr.com'
    m.from = 'jsnx21@gmail.com'
    m.subject = 'implementation of binary search in constant time'
    m.text = 'askldfafjkladsfjklsajflksadjfkl;sajfsdkjldkjaflkdf chacharon chacharon '
    end
    puts "sending email"
    puts mail
    puts client.send(mail)
end

# every '0 0 27-31 * *' do
#   task "echo 'you can use raw cron syntax too'"
# end




# loop do
#   binding.pry
#   sendgrid_email "party", :email => "jsnx21@gmail.com"
#   sleep 5
# end




# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
