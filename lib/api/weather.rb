module Weather
    DarkskyWeather::Api.configure{|c| c.api_key = ENV["DARKSKY_AUTH_TOKEN"] }
    @client = DarkskyWeather::Api::Client.new

    def self.get_weather(lat, lng)
        weather = @client.get_weather(lat: lat, lng: lng).currently
        return {temperature: weather.apparent_temperature, sky_desc: weather.summary}
    end

    def self.get_temperature(lat, lng)
        @client.get_weather(lat: lat, lng: lng).currently.apparent_temperature
    end

    def self.get_sky_description(lat, lng)
        @client.get_weather(lat: lat, lng: lng).currently.summary
    end

end