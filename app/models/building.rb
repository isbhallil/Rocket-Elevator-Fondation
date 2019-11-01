class Building < ApplicationRecord
    include RailsAdminCharts
    belongs_to :customer
    belongs_to :address
    has_many :batteries

    def weather_summary
        Weather.get_weather(self.address.latitude, self.address.longitude)
    end   

end
