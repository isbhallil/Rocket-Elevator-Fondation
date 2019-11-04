class Address < ApplicationRecord
    include RailsAdminCharts
    geocoded_by :formated_address
    before_create :init_coords
    before_update :update_coords

    has_one :customer
    has_one :building

    def get_coords
        {lat: latitude, lng: longitude}
    end

    private
    def formated_address
        [street, city, postal_code, country].compact.join(', ')
    end

    def init_coords
        if !self.latitude and !self.longitude
            ap "INIT COORDS"
            self.latitude, self.longitude = Geocoder.coordinates(formated_address)
        end
    end

    def update_coords
        self.latitude, self.longitude = Geocoder.coordinates(formated_address)
    end
end