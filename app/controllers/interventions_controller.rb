class InterventionsController < ApplicationController

  def test
    render :json => Building.select(
      :id,
      :building_type,
      "full_name_contact_person as customer_name",
      "full_name_tech_person as tech_name",
      "email_tech_person as tech_email",
      "count(batteries.id) as batteries",
      "count(columns.id) as columns",
      "count(interventions.id) as interventions",
      :floors,
      :latitude,
      :longitude,
      "count(elevators.id) as elevators"
  )
  .joins(:batteries, :columns, :elevators, :customer, :address, :interventions)
  .group("buildings.id")
  end

  def create
    intervention = Intervention.new do |i|
      i.author_id = current_user.employee.id
      i.customer_id = params["customer_id"]
      i.building_id = params["building_id"]
      i.battery_id = params["battery_id"]
      i.column_id = params["column_id"]
      i.elevator_id = params["elevator_id"]
      i.employee_id = params["employee_id"]
      i.report = params["report"]
    end

    redirect_to rails_admin_path() if intervention.try(:save!)
  end

end