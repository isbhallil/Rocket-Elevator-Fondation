class BuildingDetail < ApplicationRecord
    include RailsAdminCharts
    belongs_to :building
end
