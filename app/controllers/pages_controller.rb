class PagesController < ApplicationController

    def root
    end

    def quote
    end

    def test
        buildings = Building.select(
            :id,
            "count(batteries.id) as batteries",
            "count(columns.id) as columns",
            "count(elevators.id) as elevators"
        )
        .joins(:batteries, :columns, :elevators, :customer, :address)
        .group("buildings.id")

        current_building = Building.first

        intervention = {
            employeeId: Employee.all.sample.id,
            buildingId: current_building.id,
            result: get_random_from("success", "failure", "incomplete"),
            report: Faker::Lorem.paragraph,
            status: get_random_from("Pending" ,"InProgress" ,"Interrupted" ,"Resumed" ,"Complete")
        }

        get_intervention_type(current_building).each do |type, value|
            intervention[type] = value
        end

        get_intervention_timestamps.each do |key, value|
            intervention[key] = value
        end

        render :json => intervention
    end

    def get_random_from(*args)
        [*args].sample
    end

    def get_intervention_timestamps
        days_of_intervention = [1,2,3,4,5]

        intervention_begins_at = Faker::Time.between(from: 70.year.ago - 1, to: DateTime.now)
        intervention_finished_at = Faker::Time.between(from: intervention_begins_at, to: intervention_begins_at + days_of_intervention.sample.days)


        intervention_time_stamps = {
            intervention_begins_at: intervention_begins_at,
            intervention_finished_at: intervention_finished_at
        }

        intervention_time_stamps
    end

    def get_intervention_type(building)
        intervention_type = {
            battery: nil,
            column: nil,
            elevator: nil
        }

        type_of_intervention = get_random_from('battery', 'column', 'elevator')

        if type_of_intervention == 'battery'
            intervention_type[:battery] = building.batteries.sample.id
        elsif type_of_intervention == 'column'
            intervention_type[:column] = building.columns.sample.id
        else
            intervention_type[:elevator] = building.elevators.sample.id
        end

        intervention_type
    end
end
