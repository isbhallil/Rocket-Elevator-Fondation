class Elevator < ApplicationRecord
  include RailsAdminCharts
  include ActiveModel::Dirty
  include Notifier
  include Zendesk

  belongs_to :column
  after_update :sendTicket if :status_changed?
	
  def sendTicket
    building = self.column.battery.building
    updated_at = self.updated_at
    serial_number = self.serial_number
    body = ("Hello #{building.full_name_tech_person}, elevator #{serial_number} has changed status on #{updated_at}")
    to = '+33766846471'
    from =ENV['TWILIO_PHONE_NUMBER']

    Notifier.send_ticket(from, to, body)
    Zendesk.intervention_ticket(self.serial_number, self.column.battery.building.address, self.column.battery.building.full_name_tech_person)
  end
end