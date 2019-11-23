class MapController < ApplicationController
    before_action :is_user_admin?

    def index
        @buildings = Gmaps4rails.build_markers(Map.get_buildings) do |building, marker|
            marker.lat building['latitude']
            marker.lng building["longitude"]

            marker_picture_url =  building["interventions"].length > 0 ? "/map_pins/red.png" : "/map_pins/blue.png"
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

    private
    def is_user_admin?
        unless current_user != nil and current_user.employee?
            redirect_to root_path
        end
    end
end