require 'twilio-ruby'

class Elevator < ApplicationRecord
    include RailsAdminCharts
    belongs_to :column

    
    after_update :send_msg

    account_sid = 'ACa53e6d98eb4354b13829d86c40f07c11'
    auth_token = 'yd1d7f170d8adb95047075dd55dc3f30e'

    
    paramTwilio = {
        from: '+15017122661',
        body: 'An elevator has changed status',
        to: '+33766846471'
      }
    
      @client = Twilio::REST::Client.new(account_sid, auth_token)
      message = @client.messages.create(paramTwilio)                           
    
      puts message.sid


    puts "Elevator status changed"
    
end
