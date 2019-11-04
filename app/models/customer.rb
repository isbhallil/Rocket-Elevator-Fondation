class Customer < ApplicationRecord
  include RailsAdminCharts
  has_many :lead
  belongs_to :address, optional: true
  belongs_to :user, optional: true
  has_many :buildings
  after_update :dropbox

  def dropbox
    self.lead.all.each do |lead|
      if lead.attachment != nil
        client = DropboxApi::Client.new(ENV["DROPBOX_OAUTH_BEARER"])
        client.create_folder("/#{lead.full_name}")
        client.upload("/#{lead.full_name}/#{File.basename(lead.original_filename)}", lead.attachment)
        #PURGE LEAD
      end
    end
  end
end

