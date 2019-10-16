class BuildingDetailsController < ApplicationController
    def new
        @building_details = Building_detail.new
    end
end
