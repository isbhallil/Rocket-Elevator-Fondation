class Employee < ApplicationRecord
  include RailsAdminCharts
  belongs_to :user, dependent: :destroy
  has_many :batteries
end
