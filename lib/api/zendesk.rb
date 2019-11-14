require 'zendesk_api'
module Zendesk
    @@client = ZendeskAPI::Client.new do |config|
        config.url = ENV['ZENDESK_URL']
        config.username = ENV['ZENDESK_EMAIL']
        config.token = ENV['ZENDESK_TOKEN']
        config.retry = true
    end

    def self.contact_ticket(lead)
        ZendeskAPI::Ticket.create(@@client,
            :subject => "#{lead.full_name} from #{lead.business_name}",
            :descrpition => "Create Ticket",
            :comment => { :value => "The contact #{lead.full_name} can be reached at email #{lead.email} and at phone number #{lead.phone_number}. #{lead.building_type} has a project named #{lead.project_description} which would require contribution from Rocket Elevators.\n#{lead.project_description}\nAttached Message: #{lead.message} The Contact uploaded an attachment."},
            :submitter_id => @@client.current_user.id,
            :type => "question",
            :priority => "urgent"
        )
    end

    def self.notify_problem(subject, comment)
        ap "ZENDESK ===> NOTIFY_PROBLEM"
        ZendeskAPI::Ticket.create(@@client,
            :subject => subject,
            :descrpition => "Create Ticket",
            :comment => { :value => comment},
            :submitter_id => @@client.current_user.id,
            :type => "Problem",
            :priority => "urgent"
        )
    end

    def self.quote_ticket(quote)
        ZendeskAPI::Ticket.create(@@client,
            :subject => "#{quote.full_name} from #{quote.business_name}",
            :descrpition => "Create Ticket",
            :comment => { :value => "The contact #{quote.full_name} can be reached at email #{quote.email} and at phone number #{quote.phone_number}. #{quote.departement_in_charge_of_elevators} has a project named #{quote.project_description} which would require contribution from Rocket Elevators.\n#{quote.project_description}\nAttached Message: #{quote.message} The Contact uploaded an attachment."},
            :submitter_id => @@client.current_user.id,
            :type => "task",
            :priority => "urgent"
        )
    end

    def self.intervention_ticket(serial_number, address, full_name_tech_person)
        ZendeskAPI::Ticket.create(@@client,
            :subject => "Elevator #{serial_number} from #{address}",
            :description => "Create Ticket",
            :comment => { :value => "Hello CEO, the elevator #{serial_number} has been set to Intervention. #{full_name_tech_person} has been notified."},
            :submitter_id => @@client.current_user.id,
            :type => "notification",
            :priority => "none"
        )
    end
end