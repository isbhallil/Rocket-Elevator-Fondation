class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include RailsAdminCharts
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

      has_one :employee
      has_one :customer
      has_one :admin

      def employee?
        self.employee
      end

      def admin?
        self.admin
      end

      def customer?
        self.customer
      end

      def can_acces_intervention?
        self.admin || self.customer
      end

      def can_access_dashboard?
        self.admin
      end
end
