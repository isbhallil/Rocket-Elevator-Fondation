class InterventionsController < ApplicationController

  def new
    user = User.find(params[:format])
    if user.admin?
      @customers = Customer.all.order(:company_name)
    else
      @customers = Customer.where(user_id: user.id)
    end
  end

  def create
    id = 0
    if current_user && current_user.admin?
      id = current_user.employee.id
    elsif current_user && current_user.customer?
      id = nil
    end

    intervention = Intervention.new do |i|
      i.author_id = id
      i.customer_id = params["customer_id"]
      i.building_id = params["building_id"]
      i.battery_id = params["battery_id"]
      i.column_id = params["column_id"]
      i.elevator_id = params["elevator_id"]
      i.employee_id = params["employee_id"]
      i.report = params["report"]
    end

    redirect_to root_path() if intervention.try(:save!)
  end

end