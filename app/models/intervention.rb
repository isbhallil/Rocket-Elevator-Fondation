class Intervention < ApplicationRecord
    include RailsAdminCharts
    belongs_to :author, class_name: :Employee
    belongs_to :customer
    belongs_to :building
    belongs_to :battery, optional: true
    belongs_to :column, optional: true
    belongs_to :elevator, optional: true
    belongs_to :employee, optional: true

    before_create: :sanitize


    private
    def sanitize
        battery_id = battery_id if columnId == ""
        column_id = column_id if elevatorId == ""
        elevator_id = elevator_id
    end
end