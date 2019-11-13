class ColumnsController < ApplicationController

    def battery_columns
        render :json => Column.where(:battery_id => params[:battery_id])
    end
end
