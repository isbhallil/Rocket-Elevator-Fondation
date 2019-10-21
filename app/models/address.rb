class Address < ApplicationRecord
    include RailsAdminCharts
    has_one :customer
    has_one :building
    def name
        number_street
    end
    
end
