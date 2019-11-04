class Customer < ApplicationRecord
  include RailsAdminCharts
  has_many :lead
  belongs_to :address, optional: true
  belongs_to :user, optional: true
  has_many :buildings
  after_update :dropbox

  def dropbox
    self.lead.all.each do |lead|
      if lead.file.attached? == true
        client = DropboxApi::Client.new(ENV["DROPBOX_OAUTH_BEARER"])
        client.upload("/#{lead.full_name}/#{File.basename(lead.file.filename.to_s)}", lead.file.download)

        lead.purge_attachement
      end
    end
  end
end

