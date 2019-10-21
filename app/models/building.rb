class Building < ApplicationRecord
    include RailsAdminCharts
    belongs_to :customer
    belongs_to :address
    has_many :batteries
end
