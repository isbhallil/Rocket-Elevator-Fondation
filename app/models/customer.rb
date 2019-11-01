class Customer < ApplicationRecord
    has_many :lead
    belongs_to :address, optional: true # removed dependent destroy because a user still can use it

    include RailsAdminCharts
    
    belongs_to :user, optional: true
    has_many :buildings
    after_update :dropbox

    self.all.each do |lead|

    
     def dropbox
        self.lead.all.each do |lead|
          if lead.attachment != nil
            client = DropboxApi::Client.new(ENV["DROPBOX_OAUTH_BEARER"])
            client.create_folder("/#{lead.full_name}")
            client.upload("/#{lead.full_name}/#{File.basename(lead.original_filename)}", lead.attachment)
            
            
              # lead.file_attachment = nil
              # lead.original_filename = nil
              # lead.save!

              end
            end
        end
    end   
end

