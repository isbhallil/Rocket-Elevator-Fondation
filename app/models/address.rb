class Address < ApplicationRecord
    has_one :customer
    has_one :building
    def name
        number_street
    end
end
