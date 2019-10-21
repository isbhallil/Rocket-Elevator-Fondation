class Battery < ApplicationRecord
    include RailsAdminCharts
    belongs_to :building
    belongs_to :employee
    has_many :columns
end
