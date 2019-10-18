class Customer < ApplicationRecord
    belongs_to :address, dependent: :destroy, optional: true
    belongs_to :user, optional: true
    has_many :buildings
end
