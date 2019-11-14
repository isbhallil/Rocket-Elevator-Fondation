class Intervention < ApplicationRecord
    include RailsAdminCharts
    belongs_to :author, class_name: :Employee
    belongs_to :customer
    belongs_to :building
    belongs_to :battery, optional: true
    belongs_to :column, optional: true
    belongs_to :elevator, optional: true
    belongs_to :employee, optional: true

    before_save :sanitize
    after_create :notify_problem

    def without_noise
        self.as_json({except: [:intervention_begins_at, :intervention_finished_at, :created_at, :updated_at]}).delete_if {|key, value| value == nil && key != "report" }
    end

    private
    def sanitize
        self.battery_id = "" if self.column_id
        self.column_id = "" if self.elevator_id
    end

    def notify_problem
        Zendesk.notify_problem(self.without_noise)
    end
end