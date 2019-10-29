
class Elevator < ApplicationRecord
    include RailsAdminCharts
    belongs_to :column

    require 'twilio-ruby'

    
    after_update do |elevator|


    paramTwilio = {
        from: '+15712976606',
        body: 'An elevator has changed status',
        to: '+33766846471'
    }
    
    account_sid = 'ACa53e6d98eb4354b13829d86c40f07c11'
    auth_token = 'd1d7f170d8adb95047075dd55dc3f30e'

    @client = Twilio::REST::Client.new(account_sid, auth_token)
    message = @client.messages.create(paramTwilio)                         
    
      puts message.sid

    end

    puts "Elevator status changed"
    
end
