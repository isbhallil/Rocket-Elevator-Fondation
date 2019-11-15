class MapController < ApplicationController
    before_action :is_user_admin?

    def index
        load_markers
    end

    private
    def is_user_admin?
        unless current_user != nil and current_user.employee?
            redirect_to root_path
        end
    end

    def load_markers
        @buildings = Gmaps4rails.build_markers(get_buildings) do |building, marker|
            marker.lat building['latitude']
            marker.lng building["longitude"]

            marker_picture_url = "/map_pins/red.png" ? building["interventions_to_do"].length > 0 : "/map_pins/blue.png"
            marker.picture({
                "url" => marker_picture_url,
                "width" => 35,
                "height" => 30
            })

            marker.infowindow render_to_string(
                :partial => "/map/info_window",
                :locals => {:building => building}
            )
        end
    end

    def get_buildings
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

        buildings = JSON.parse(buildings.to_json)
        buildings.map do |building|
            interventions_to_do = []

            building["interventions"].each do |intervention|
                if intervetnion["status"] == "Pending"
                    interventions_to_do << {thing: "intervetnion", id: intervetnion["id"]}
                end
            end

            building["batteries"].each do |battery|
                if battery["status"] == "Intervention"
                    interventions_to_do << {thing: "battery", id: battery["id"]}
                end
            end

            building["columns"].each do |column|
                if column["status"] == "Intervention"
                    interventions_to_do << {thing: "columns", id: column["id"]}
                end
            end

            building["elevators"].each do |elevator|
                if elevator["status"] == "Intervention"
                    interventions_to_do << {"thing": "elevator", "id": elevator["id"]}
                end
            end

            building["batteries"] = building["batteries"].length
            building["columns"] = building["columns"].length
            building["elevators"] = building["elevators"].length
            building["interventions_to_do"] = interventions_to_do

            building
        end
    end
end