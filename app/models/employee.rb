class Employee < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
