require 'zendesk_api'
require './lib/api/zendesk.rb'
require 'dropbox_api'
class LeadController < ApplicationController
  skip_before_action :verify_authenticity_token



  def create
    @lead = Lead.new
    @lead.full_name = params["lead_full_name"]
    @lead.business_name = params["lead_business_name"]
    @lead.email = params["lead_email"]
    @lead.phone_number = params["lead_phone_number"]
    @lead.building_project_name = params["lead_project_name"]
    @lead.project_description = params["lead_project_desc"]
    @lead.message = params["lead_message"]
    @lead.building_type = (params["lead_building_type"])

    params_attach = params["lead_file"]
    puts params_attach
        @lead.file.attach(params["lead_file"])
        @lead.original_filename = params_attach.original_filename
    

    if @lead.try(:save)
        LeadsMailer.leads_email(@lead).deliver
        # @lead.file.purge
        redirect_to root_path
    else
        ap "NOT WORKING"
    end

    def cleaned_building_type(param)
        if param == "--- select a building type  ---"
            return nil
        end

        return param
    end
  end
end