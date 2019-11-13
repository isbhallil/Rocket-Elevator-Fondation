class ElevatorsController < ApplicationController
    def column_elevators
        render :json => Elevator.where(:column_id => params[:column_id])
    end
end