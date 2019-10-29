require 'zendesk_api'
require './lib/api/zendesk.rb'
class Quote < ApplicationRecord
    include RailsAdminCharts

    def quote_ticket
        zendesk = Zendesk.new
        zendesk.ticket(self.full_name, self.business_name, self.email, self.phone_number, self.building_project_name, self.project_description, self.message, self.departement_in_charge_of_elevators)
    end
end
