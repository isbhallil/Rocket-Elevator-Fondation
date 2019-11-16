class BuildingsController < ApplicationController
    def customer_buildings
        render :json => Building.select(:street, 'buildings.id as id').joins(:address).where(:customer_id => params[:customer_id])
    end
end
