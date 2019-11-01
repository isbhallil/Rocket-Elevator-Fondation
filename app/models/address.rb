class Address < ApplicationRecord
    include RailsAdminCharts
    has_one :customer
    has_one :building
end
