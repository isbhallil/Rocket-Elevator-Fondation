class Elevator < ApplicationRecord
  include RailsAdminCharts
  include ActiveModel::Dirty
  include Notifier
  include Zendesk

  belongs_to :column
  after_update :sendTicket, :status_changed if :status_changed?

  def sendTicket
    building = self.column.battery.building
    updated_at = self.updated_at
    serial_number = self.serial_number
    body = ("Hello #{building.full_name_tech_person}, elevator #{serial_number} has changed status on #{updated_at}")
    to = '+15819831152'
    from =ENV['TWILIO_PHONE_NUMBER']

    Notifier.send_ticket(from, to, body)
    Zendesk.intervention_ticket(self.serial_number, self.column.battery.building.address, self.column.battery.building.full_name_tech_person)
  end

  def status_changed
    notifier = Slack::Notifier.new(ENV['Slack_Webhook'], channel: ENV['Slack_Channel'], username: ENV['Slack_Username'])
    notifier.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{previous_changes[:status][0]} to #{self.status}"
  end

end