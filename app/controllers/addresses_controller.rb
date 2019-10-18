class AddressesController < ApplicationController
    def new
        @addresses = Address.all
    end
end
