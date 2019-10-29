# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#SendGrid
ActionMailer::Base.smtp_settings = {
    :user_name => 'Rocket2020',
    :password => 'Codeboxx1',
    :domain => 'localhost:3000',
    :address => 'rocketelevators@codeboxx.biz',
    :port => 587, #was 587 initially
    :authentication => :plain,
    :enable_starttls_auto => true
  }
