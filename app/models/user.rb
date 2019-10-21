class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include RailsAdminCharts
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  has_one :employee


  def is_admin?
    self.employee
  end


  def name
    id
  end
end