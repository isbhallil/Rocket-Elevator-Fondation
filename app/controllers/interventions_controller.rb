class InterventionsController < ApplicationController

  def create
    intervention = Intervention.new do |i|
      i.author_id = params["author_id"]
      i.customer_id = params["customer_selector"]
      i.building_id = params["building_id"]
      i.battery_id = params["battery_id"]
      i.column_id = params["column_id"]
      i.elevator_id = params["elevator_id"]
      # i.employee_id = params["employee_id"],
      # i.report = params["report"]
    end

    ap "InterventionController#Create"
    ap intervention

    intervention.save!
  end

end