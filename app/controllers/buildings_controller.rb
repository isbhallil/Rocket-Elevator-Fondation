class BuildingsController < ApplicationController

    def customer_buildings
        ap "CUSTOMER_BUILDINGS"
        ap params[:customer_id]
        buildings = Building.where(:customer_id => params[:customer_id])
        ap buildings
        render :json => buildings
    end
end
