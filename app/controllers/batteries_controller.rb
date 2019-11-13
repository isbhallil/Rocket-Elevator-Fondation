class BatteriesController < ApplicationController
    def building_batteries
        render :json => Battery.where(:building_id => params[:building_id])
    end
end
