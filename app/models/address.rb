class Address < ApplicationRecord
    include RailsAdminCharts
    geocoded_by :formated_address
    after_validation :geocode

    has_one :customer
    has_one :building

    private
    def formated_address
        return "#{self.number_street}, #{city}, #{postal_code} #{country}"
    end
end
