require 'twilio-ruby'
module Notifier
    # set up a client to talk to the Twilio REST API
    # HOW IN THE FUCKING WORLD ?
    @@client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    
    def self.send_ticket(from, to, body) 
        ap "@@client"
        @@client.messages.create(from: from, to: to, body: body)
    end
end