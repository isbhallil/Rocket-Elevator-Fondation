class Address < ApplicationRecord
    include RailsAdminCharts
    geocoded_by :formated_address
    after_validation :geocode,  :latitude => :latitude, :longitude => :longitude
    after_update :geocode

    has_one :customer
    has_one :building

    private
    def formated_address
        [number_street, city, postal_code, country].compact.join(', ')
    end
end