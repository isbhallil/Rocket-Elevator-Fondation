class Quote < ApplicationRecord
    include RailsAdminCharts
    include ActiveModel::Dirty

    # belongs_to :lead but leads need to migrate first
    after_create :send_quote

    def send_quote
        Zendesk.quote_ticket(self)
        #Zendesk.quote_ticket(self.full_name, self.business_name, self.email, self.phone_number, self.building_project_name, self.project_description, self.message, self.departement_in_charge_of_elevators)
    end
end