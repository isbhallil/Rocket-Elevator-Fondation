class InterventionsController < ApplicationController

  def new
    @intervention = Intervention.create({
      author_id = params["author_id"]
      customer_id = params["customer_id"]
      building_id = params["building_id"]
      battery_id = params["battery_id"]
      column_id = params["column_id"]
      elevator_id = params["elevator_id"]
      employee_id = params["employee_id"]
      report = params["report"]
    })
  end

end