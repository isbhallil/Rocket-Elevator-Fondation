class Lead < ApplicationRecord
    include RailsAdminCharts
    has_one_attached :file

    private
    def purge_attachement
        if self.file.attached?
            self.file.purge
        end
    end
end