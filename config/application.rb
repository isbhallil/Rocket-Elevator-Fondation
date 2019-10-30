require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ENV.update YAML.load_file('config/application.yml')[Rails.env] rescue {}

module RocketElevatorsInformationSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    #SendGrid
    ActionMailer::Base.smtp_settings = {
    :user_name => 'apikey',
    :password => ENV['SendGrid_Key'],
    :domain => 'rocketgb.best',
    :address => 'smtp.sendgrid.net',
    :port => 587, #was 587 initially
    :authentication => :plain,
    :enable_starttls_auto => true
    }

  end
end

