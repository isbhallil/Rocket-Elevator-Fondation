class BuildingsController < ApplicationController
    def customer_buildings
        buildings = Building.where(:customer_id => params[:customer_id])
        render :json => buildings
    end
end
