class Building < ApplicationRecord

    include RailsAdminCharts
    belongs_to :customer
    belongs_to :address
    has_many :batteries
    
    @client = DarkskyWeather::Api::Client.new
    lat, lng = [37.8267, -122.4233]
    @client.get_weather(lat: lat, lng: lng)

end
