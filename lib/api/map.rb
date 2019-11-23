module Map

    def self.format_buildings_for_markers(buildings)
        buildings = JSON.parse(buildings.to_json)
        buildings.map do |building|
            interventions_to_do = []

            building["interventions"].each do |intervention|
                if intervention["status"] == "Pending"
                    interventions_to_do << {thing: "intervetnion", id: intervention["id"]}
                end
            end

            building["batteries"] = building["batteries"].length
            building["columns"] = building["columns"].length
            building["elevators"] = building["elevators"].length
            building["interventions_to_do"] = interventions_to_do

            building
        end
    end

    def self.get_buildings
        buildings = Building.select(
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

        Map.format_buildings_for_markers(buildings)
    end


end