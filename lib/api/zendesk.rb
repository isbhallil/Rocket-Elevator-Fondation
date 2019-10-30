require 'zendesk_api'
require 'dotenv/load'
class Zendesk
     
    def initialize
        ap "initializing" 
        @client = ZendeskAPI::Client.new do |config|
            config.url = "https://rocketelevatorshelp.zendesk.com/api/v2"
            config.username = "sarah_bechik@hotmail.com"
            config.token = ENV["ZENDESK_TOKEN"]
            config.retry = true
        end
    end

    
    def contact_ticket(full_name, business_name, email, phone_number, building_project_name, project_description, message, departement_in_charge_of_elevators)
        ap "ZENDESK CONTACT TICKET==============================================================="
        ap @client
        ap "CLIENT TEST"
        ZendeskAPI::Ticket.create(@client, :subject => "#{full_name} from #{business_name}", :descrpition => "Create Ticket", :comment => { :value => "The contact #{full_name} can be reached at email #{email} and at phone number #{phone_number}. #{departement_in_charge_of_elevators} has a project named #{project_description} which would require contribution from Rocket Elevators.\n#{project_description}\nAttached Message: #{message} The Contact uploaded an attachment."}, :submitter_id => @client.current_user.id, :type => "question", :priority => "urgent")
    end

    def quote_ticket(full_name, business_name, email, phone_number, building_project_name, project_description, message, departement_in_charge_of_elevators)
        ZendeskAPI::Ticket.create(@client, :subject => "#{full_name} from #{business_name}", :descrpition => "Create Ticket", :comment => { :value => "The contact #{full_name} can be reached at email #{email} and at phone number #{phone_number}. #{departement_in_charge_of_elevators} has a project named #{project_description} which would require contribution from Rocket Elevators.\n#{project_description}\nAttached Message: #{message} The Contact uploaded an attachment."}, :submitter_id => @client.current_user.id, :type => "task", :priority => "urgent")
    end        
end