class Elevator < ApplicationRecord
    include RailsAdminCharts
    belongs_to :column

    after_update :status_changed
    def status_changed
        SlackNotifier::CLIENT.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{previous_changes[:status][0]} to #{self.status}"
    end

end
