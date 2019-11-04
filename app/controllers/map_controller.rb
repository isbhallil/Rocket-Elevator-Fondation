class MapController < ApplicationController
    before_action :is_user_admin?

    def index
        load_markers
    end

    def test
        render :json => get_buildings
    end

    private
    def is_user_admin?
        ap current_user
    end

    def load_markers
        @buildings = Gmaps4rails.build_markers(get_buildings) do |building, marker|
            marker.lat building['latitude']
            marker.lng building["longitude"]

            @battery = rand(10..90)
            @ip = "192.168."+rand(0..255).to_s+"."+rand(15..250).to_s
            @connected = rand(50..100)

            if building["interventions_to_do"].length > 0
                marker_picture_url = "/map_pins/red.png"
            else
                marker_picture_url = "/map_pins/blue.png"
            end

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
            :floors,
            :latitude,
            :longitude,
            "count(elevators.id) as elevators"
        )
        .joins(:batteries, :columns, :elevators, :customer, :address)
        .group("buildings.id")

        buildings = JSON.parse(buildings.to_json)
        buildings.map do |building|
            interventions_to_do = []

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