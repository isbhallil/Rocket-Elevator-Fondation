# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#SendGrid
ActionMailer::Base.smtp_settings = {
    :user_name => 'apikey',
    :password => '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',
    :domain => 'rocketgb.best',
    :address => 'smtp.sendgrid.net',
    :port => 587, #was 587 initially
    :authentication => :plain,
    :enable_starttls_auto => true
  }
