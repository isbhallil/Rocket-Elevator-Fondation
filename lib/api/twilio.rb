module Twilio

    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    
    
    def self.send_ticket(status) 

        message = @client.messages.create(paramTwilio)
        status = nil
        paramTwilio = {
            from: '+15712976606',
            body: 'An elevator has changed status',
            to: '+33766846471'
        } 
    end
end