class Customer < ApplicationRecord

    belongs_to :address, optional: true # removed dependent destroy because a user still can use it

    include RailsAdminCharts
    
    belongs_to :user, optional: true
    has_many :buildings
    
end
