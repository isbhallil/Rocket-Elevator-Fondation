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
