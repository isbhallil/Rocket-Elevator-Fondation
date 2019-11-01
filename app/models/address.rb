class Address < ApplicationRecord
    include RailsAdminCharts
    geocoded_by :formated_address
    after_validation :geocode,  :latitude => :latitude, :longitude => :longitude
    after_update :geocode

    has_one :customer
    has_one :building

    def get_coords
        Geocode.get_lat_lng(formated_address);
    end

    private
    def formated_address
        [street, city, postal_code, country].compact.join(', ')
    end
end