class LeadController < ApplicationController
    # require 'activestorage-dropbox'
    require 'dropbox_api'
    skip_before_action :verify_authenticity_token
def create

    # puts "CREATE"
    # puts params

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
    puts "****************************************************************************************"
    puts params_attach.size()
    puts "****************************************************************************************"
    # @lead.file = params["contact"]["attachment"]

    if params_attach
        @lead.attachment = params_attach.read
        @lead.original_filename = params_attach.original_filename
       


    # self.all.each do |lead|

    # @lead.original_filename = params["contact"]["attachment"]
    dropbox_client = DropboxApi::Client.new(ENV['DROPBOX_OAUTH_BEARER'])
    
    #dropbox_client.create_folder("/#{@lead.full_name}")
    #dropbox_client.upload("/#{@lead.full_name}/#{File.basename(@lead.original_filename)}/#{File.extname(@lead.original_filename)}", lead.attachment)
    # dropbox_client.upload("/test_serge_carosse1/ruby_carosse.jpg", params_attach.read())
    # listed_folders = dropbox_client.list_folder("/patete")
    # puts listed_folders


    
    # @lead.file.attach(file)
    @lead.save
    redirect_to root_path

    # client.upload("/#{self.company_name}/#{File.basename(lead.original_file_name)}_#{File.extname(lead.original_file_name)}", lead.file_attachment)

        end
    end
end
