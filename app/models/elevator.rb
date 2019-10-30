require 'twilio-ruby'
require 'dotenv/load'

class Elevator < ApplicationRecord
    include RailsAdminCharts
    include ActiveModel::Dirty

    belongs_to :column
    
    after_update do |elevator|

    paramTwilio = {
        from: '+15712976606',
        body: 'An elevator has changed status',
        to: '+33766846471'
    }

    @client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    message = @client.messages.create(paramTwilio)                         
    
      puts message.sid

    end

    puts "Elevator status changed"
    
end
