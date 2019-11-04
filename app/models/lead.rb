class Lead < ApplicationRecord
    include RailsAdminCharts
    include ActiveModel::Dirty
    belongs_to :customer, optional:true
    has_one_attached :attachmentrake
    has_one_attached :file
    after_create :send_contact

    private
    def purge_attachement
        if self.file.attached?
            self.file.purge
        end
    end

    def send_contact
        Zendesk.contact_ticket(self)
    end
end