class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include RailsAdminCharts
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

      has_one :employee
      # belongs_to :employee, optional: true

      def employee?
        self.employee
      end
end
