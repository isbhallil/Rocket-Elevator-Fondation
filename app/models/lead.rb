require 'zendesk_api'
require './lib/api/zendesk.rb'

class Lead < ApplicationRecord
    include RailsAdminCharts
    include ActiveModel::Dirty

    has_one_attached :file

    after_create :send_ticket

    def send_ticket
        ap "LEAD CONTACT_TICKET ==============================="
        Zendesk.new.contact_ticket(self.full_name, self.business_name, self.email, self.phone_number, self.building_project_name, self.project_description, self.message, self.departement_in_charge_of_elevators)
    end


end

