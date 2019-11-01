class Lead < ApplicationRecord
    include RailsAdminCharts
    include ActiveModel::Dirty
    belongs_to :customer, optional:true
    has_one_attached :attachmentrake 
    has_one_attached :file
  # has_one :quote

    after_create :send_contact

    def send_contact
        Zendesk.contact_ticket(self)
        # Zendesk.contact_ticket(self.full_name, self.business_name, self.email, self.phone_number, self.building_project_name, self.project_description, self.message, self.departement_in_charge_of_elevators)
    end
end