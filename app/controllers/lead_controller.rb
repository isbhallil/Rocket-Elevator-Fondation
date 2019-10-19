class LeadController < ApplicationController
    skip_before_action :verify_authenticity_token
def create

 puts params

 @lead = Lead.new

    @lead.full_name = params["contact"]["name"]
    @lead.business_name = params["contact"]["subject"]
    @lead.email = params["contact"]["email"]
    @lead.phone_number = params["contact"]["phone"]
    @lead.building_project_name = params["contact"]["project"]
    @lead.project_description = params["contact"]["project_desc"]
    @lead.message = params["contact"]["message"]
    @lead.departement_in_charge_of_elevators = params["contact"]["department"]

    file = params["contact"]["attachment"]
    @lead.file.attach(file )
    @lead.save!
    redirect_to root_path
end
end
