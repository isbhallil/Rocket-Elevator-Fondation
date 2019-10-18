class CustomersController < ApplicationController
    def new
        @customers = Customer.new
    end
end
