class Elevator < ApplicationRecord
    include RailsAdminCharts
    belongs_to :column
end
