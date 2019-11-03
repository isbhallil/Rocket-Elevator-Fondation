require 'uri'
require 'net/http'
require 'openssl'
require 'awesome_print'

module Stock
    include StockModuleInit

    def self.display_bitcoin
        testing = request.display_bitcoin.properties
        return {source: testing.source, price: testing.last_price}
    end
end


