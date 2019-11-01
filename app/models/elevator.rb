class Elevator < ApplicationRecord
  include RailsAdminCharts
  include ActiveModel::Dirty
  include Notifier

  belongs_to :column
  after_update :sendTicket if :status_changed?
	
  def sendTicket
    building = self.column.battery.building
    updated_at = self.updated_at
    serial_number = self.serial_number
    body = ("Hello #{building.full_name_tech_person}, elevator #{serial_number} has changed status on #{updated_at}")
    to = '+33766846471'
    from = '+15712976606'

    Notifier.send_ticket(from, to, body)
  end
end