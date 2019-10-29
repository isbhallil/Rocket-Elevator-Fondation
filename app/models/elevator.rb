class Elevator < ApplicationRecord
    include RailsAdminCharts
    belongs_to :column

    #Slack Automatic Message
    after_update :status_changed
    def status_changed
        #The Elevator [ID Elevator] with Serial Number [Serial Number] changed status from [Old Status] to [New Status]
        SlackNotifier::CLIENT.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{previous_changes[:status][0]} to #{self.status}"
    end

end
