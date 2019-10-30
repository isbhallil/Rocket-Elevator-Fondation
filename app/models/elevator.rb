class Elevator < ApplicationRecord
    include RailsAdminCharts
    belongs_to :column
    after_update :status_changed
    
    def status_changed
        notifier = Slack::Notifier.new(ENV['Slack_Webhook'], channel: ENV['Slack_Channel'], username: ENV['Slack_Username'])
        notifier.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{previous_changes[:status][0]} to #{self.status}"
    end

end