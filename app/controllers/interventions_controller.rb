class InterventionsController < ApplicationController

  def new
    @intervention = Intervention.new
    @intervention.author = params["author_id"]
    @intervention.customer = params["customer_id"]
    @intervention.building = params["building_id"]
    @intervention.battery = params["battery_id"]
    @intervention.column = params["column_id"]
    @intervention.elevator = params["elevator_id"]
    @intervention.employee = params["employee_id"]
    @intervention.report = params["repor_id"]

    @intervention.try(:save!)
  end

end