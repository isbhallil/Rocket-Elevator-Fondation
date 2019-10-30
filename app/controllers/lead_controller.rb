class LeadController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create

        lead = Lead.new({
            full_name: params["lead_full_name"],
            business_name: params["lead_business_name"],
            email: params["lead_email"],
            phone_number: params["lead_phone_number"],
            building_project_name: params["lead_project_name"],
            project_description: params["lead_project_desc"],
            message: params["lead_message"],
            building_type: cleaned_building_type(params["lead_building_type"]),
            file: params["lead_file"]
        })

        if lead.try(:save!)
            redirect_to root_path
        end
    end

    private
    def cleaned_building_type(param)
        if param == "--- select a building type  ---"
            return nil
        end

        return param
    end

end