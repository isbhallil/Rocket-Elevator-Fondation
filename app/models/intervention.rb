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

    def notification_message
        intervention = Intervention
            .select('buildings.id as building_id', :street, :city, :full_name_tech_person, :email_tech_person, :phone_number_tech_person, :company_name, :email_contact_person, :phone_number_contact_person)
            .joins(:building, :customer, "LEFT JOIN addresses ON buildings.address_id = addresses.id")
            .where(`interventions.id = #{id}`)[0]

        summary = "Intervention needed at #{intervention.street}, #{intervention.city} on building #{intervention.building_id} \n"
        summary << "#{'element: battery: ' + battery_id.to_s + "\n" if battery_id}"
        summary << "#{'column: ' + column_id.to_s + "\n" if column_id}"
        summary << "#{'elevator: ' + elevator_id.to_s + "\n" if elevator_id}"
        summary << "customer: #{company_name}, #{email_contact_person}, #{phone_number_contact_person} \n"
        summary << "tech: #{intervention.full_name_tech_person}, #{intervention.email_tech_person}, #{intervention.phone_number_tech_person}"

        summary
    end
    private
    def sanitize
        ap self
        self.battery_id = "" if self.column_id
        self.column_id = "" if self.elevator_id
        ap self
    end


    def notify_problem
        # Zendesk.notify_problem(self.notification_message)
    end
end