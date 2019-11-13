class Employee < ApplicationRecord
  include RailsAdminCharts
  belongs_to :user, dependent: :destroy
  has_many :batteries

  def badge
    "#{id} | #{last_name} #{first_name}"
  end
end
