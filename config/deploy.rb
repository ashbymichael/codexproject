set :sendgrid_email, "sends an email with sendgrid"
require "whenever/capistrano"

#after 'deploy:symlink', 'deploy:sendgrid_email'

namespace :deploy do
  desc 'sends an email via sendgrid'
  task :sendgrid_email, :email => "jsnx21@gmail.com" do
    sengrid "email", :email => "jsnx21@gmail.com"
  end

end
