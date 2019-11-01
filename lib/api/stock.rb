require 'uri'
require 'net/http'
require 'openssl'

module Stock
    url = URI("https://bravenewcoin-v1.p.rapidapi.com/ticker?show=usd&coin=btc")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = ENV['STOCK_ACCOUNT_SID']
    request["x-rapidapi-key"] = ENV['STOCK_AUTH_TOKEN']
    
    response = http.request(request)
    puts response.read_body
    
end

