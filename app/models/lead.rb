class Lead < ApplicationRecord
    include RailsAdminCharts
    belongs_to :customer, optional:true
    has_one_attached :file
end
