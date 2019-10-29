# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#SendGrid
ActionMailer::Base.smtp_settings = {
    :user_name => '	apikey',
    :password => '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',
    :domain => 'rocketgb.best',
    :address => 'smtp.sendgrid.net',
    :port => 587, #was 587 initially
    :authentication => :plain,
    :enable_starttls_auto => true
  }
