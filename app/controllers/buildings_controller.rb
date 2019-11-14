class BuildingsController < ApplicationController
    def customer_buildings
        render :json => Building.where(:customer_id => params[:customer_id])
    end
end
