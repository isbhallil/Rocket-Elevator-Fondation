module Geocode

    def self.get_lat_lng(address)
        Geocode.search(address)
    end
end