require 'uri'
require 'net/http'
require 'openssl'
require 'awesome_print'

module StockModuleInit
    url = URI("https://bravenewcoin-v1.p.rapidapi.com/ticker?show=usd&coin=btc")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'bravenewcoin-v1.p.rapidapi.com'
    request["x-rapidapi-key"] = 'b9bfde98c7msh265c1d083e3522dp1bee44jsne432d0ff94bd'
    
    response = http.request(request)
    puts response.read_body 
end