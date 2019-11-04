class Quote < ApplicationRecord
    include RailsAdminCharts
    include ActiveModel::Dirty

    # belongs_to :lead but leads need to migrate first
    after_create :send_quote

    def send_quote
        Zendesk.quote_ticket(self)
    end
end