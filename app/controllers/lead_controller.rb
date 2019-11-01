class LeadController < ApplicationController
  
    require 'dropbox_api'
    skip_before_action :verify_authenticity_token
def create

    @lead = Lead.new

    @lead.full_name = params["contact"]["name"]
    @lead.business_name = params["contact"]["subject"]
    @lead.email = params["contact"]["email"]
    @lead.phone_number = params["contact"]["phone"]
    @lead.building_project_name = params["contact"]["project"]
    @lead.project_description = params["contact"]["project_desc"]
    @lead.message = params["contact"]["message"]
    @lead.departement_in_charge_of_elevators = params["contact"]["department"]
    params_attach = params["contact"]["attachment"] 
    
    if params_attach
        @lead.attachment = params_attach.read
        @lead.original_filename = params_attach.original_filename
        
    dropbox_client = DropboxApi::Client.new(ENV['DROPBOX_OAUTH_BEARER'])
    
    @lead.save
    redirect_to root_path

       end
    end
end
