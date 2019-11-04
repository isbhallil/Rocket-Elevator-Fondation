class Building < ApplicationRecord
    include RailsAdminCharts
    belongs_to :customer
    belongs_to :address
    has_many :batteries
    has_many :columns, through: :batteries
    has_many :elevators, through: :columns

    def weather_summary
        Weather.get_weather(45.5017, -73.5673)
    end
end