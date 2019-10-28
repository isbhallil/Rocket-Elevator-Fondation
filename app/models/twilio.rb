class Twilio < ApplicationRecord

    paramTwilio = {
        from: '+15017122661',
        body: 'An elevator has changed status',
        to: '+15558675310'
      }
    
      @client = Twilio::REST::Client.new(account_sid, auth_token)
      message =@client.messages.create(paramTwilio)                           
    
      puts message.sid

      
end
