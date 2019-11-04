require 'zendesk_api'
require './lib/api/zendesk.rb'
require 'dropbox_api'
class LeadController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @lead = Lead.new
    @lead.full_name = params["lead_full_name"]
    @lead.business_name = params["lead_business_name"]
    @lead.email = params["lead_full_name"]
    @lead.phone_number = params["lead_phone_number"]
    @lead.building_project_name = params["lead_project_name"]
    @lead.project_description = params["lead_project_desc"]
    @lead.message = params["lead_message"]
    @lead.building_type = params["lead_building_type"]

    params_attach = params["lead_file"]
    if params_attach
        @lead.attachment = params_attach.read
        @lead.original_filename = params_attach.original_filename
        dropbox_client = DropboxApi::Client.new(ENV['DROPBOX_OAUTH_BEARER'])
    end

    if @lead.try(:save)
        LeadsMailer.leads_email(@lead).deliver
        redirect_to root_path
    end

    # private
    def cleaned_building_type(param)
        if param == "--- select a building type  ---"
            return nil
        end

        return param
    end
  end
end