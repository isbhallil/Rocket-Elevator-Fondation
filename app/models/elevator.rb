require 'twilio-ruby'
class Elevator < ApplicationRecord
    include RailsAdminCharts
    include ActiveModel::Dirty

    belongs_to :column

# do we really need after_update if there's if?

    after_update :sendTicket if :status_changed?
	
      def sendTicket
        
        Twilio.send_ticket(status).message
  
      end
        
end

    
