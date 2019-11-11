class Lead < ApplicationRecord
    include RailsAdminCharts
    include ActiveModel::Dirty
    belongs_to :customer, optional:true
    has_one_attached :file
    after_create :send_contact

    def purge_attachement
        if self.file.attached?
            self.file.purge
        end
    end

    private

    def send_contact
        # Zendesk.contact_ticket(self)
    end
end