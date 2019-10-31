require './lib/api/zendesk.rb'
class Quote < ApplicationRecord
    include RailsAdminCharts
    #include ActiveModel::Dirty

    belongs_to :lead

    after_create do |q|
            
            Zendesk.new.quote_ticket(self.full_name, self.business_name, self.email, self.phone_number, self.building_project_name, self.project_description, self.message, self.departement_in_charge_of_elevators)

    end
end
