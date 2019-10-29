
require './lib/api/zendesk.rb'
class Lead < ApplicationRecord
    include RailsAdminCharts
    has_one_attached :file

    def contact_ticket
        zendesk = Zendesk.new
        zendesk.contact_ticket(self.full_name, self.business_name, self.email, self.phone_number, self.building_project_name, self.project_description, self.message, self.departement_in_charge_of_elevators)
    end


end

