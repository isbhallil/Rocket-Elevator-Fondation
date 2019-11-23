require 'bcrypt'
require 'devise'
require 'csv'

def formated(string)
    string.gsub("'","''")
end


# # # EMPLOYEES
JSON.parse(File.read('lib/seed/employee.js')).each do |e|
    ap "EMPLOYEE"
    user = User.create!({"email": e["email"], "password": "12345678", "password_confirmation": "12345678" })
    Employee.create({user: user, "first_name": e["first_name"], "last_name": e["last_name"],"title": e["title"], "email": e["email"], "encrypted_password": "12345678"})
end

# # # ADMINS
JSON.parse(File.read('lib/seed/admin.js')).each do |e|
    ap "ADMIN"
    user = User.create!({"email": e["email"], "password": "12345678", "password_confirmation": "12345678" })
    Admin.create({user: user})
    employee = Employee.create({user: user, "first_name": e["first_name"], "last_name": e["last_name"],"title": e["title"], "email": e["email"], "encrypted_password": "12345678"})
end

# # # LEAD
building_types = ['residential', 'corporate', 'commercial', 'hybrid']
JSON.parse(File.read('lib/seed/leads.js')).each do |l|
    ap "LEAD"
    Lead.create({
        "full_name": l["full_name"],
        "business_name": l["business_name"],
        "email": l["email"],
        "phone_number": l["phone_number"],
        "building_project_name": l["building_project_name"],
        "project_description": l["project_description"],
        "message": l["message"],
        "building_type": building_types[Faker::Number.within(range: 0..3)]
    })
end


# # # ADDRESSES
JSON.parse(File.read('lib/seed/address.js')).each do |a|
    ap "ADDRESS"
    Address.create({
        "status": "Active",
        "entity": "Building",
        "street": a["number_street"],
        "apt_number": rand(1..50),
        "city": a["city"],
        "postal_code": a["postalCode"],
        "country": "US",
        "notes": Faker::Lorem.sentence(),
        "longitude": a["coordinates"]["lng"],
        "latitude": a["coordinates"]["lat"]
    })
end

# # # ELEVATORS
def seed_elevator(column_id)
    model_types = ["Standard", "Premium", "Excelium"]
    statuses = ["Running", "Running", "Running", "Running", "Intervention"]
    ap "ELEVATOR"
    Elevator.create({
        "column_id": column_id,
        "serial_number": Faker::Alphanumeric.alpha(number: 15),
        "model_type": model_types[rand(0..2)],
        "status": statuses[rand(0..4)],
        "date_of_installation": "3/23/2017",
        "date_of_inspection": "9/17/2018",
        "inspection_certificate": Faker::Alphanumeric.alpha(number: 25),
        "information": Faker::Lorem.sentence(),
        "notes": Faker::Lorem.sentence(),
        "created_at": "1/13/2019",
        "updated_at": "6/8/2017"
    })
end

# # # COLUMNS
def seed_column(battery_id)
    statuses = ["On", "Off", "Intervention"]
    ap "COLUMN"
    column_id = Column.create({
        "battery_id": battery_id,
        "status": statuses[rand(0..2)],
        "information": Faker::Lorem.sentence(),
        "notes": Faker::Lorem.sentence(),
        "created_at": "2017-12-26",
        "updated_at": "2017-10-07"
    }).id

    rand(1..5).times do
        seed_elevator(column_id)
    end
end

# # # BATTERY
def seed_battery(building_id)
    date_of_installation = Faker::Date.between(from: 70.years.ago, to: Date.today)
    date_of_inspection = Faker::Date.backward(days: 14)
    employee_id = rand(1..Employee.count)
    ap "BATTERY"

    battery_id = Battery.create({
        "building_id": building_id,
        "employee_id": employee_id,
        "status": "Inactive",
        "date_of_installation": date_of_installation.to_s,
        "date_of_inspection": date_of_inspection.to_s,
        "inspection_certificate": "Certified",
        "information": Faker::Lorem.sentence(),
        "notes": Faker::Lorem.sentence(),
        "created_at": "11/19/1985",
        "updated_at": "9/3/2008"
    }).id

    ap "FINISH"

    rand(1..5).times do
        seed_column(battery_id)
    end
end


# # # BUILDING
def seed_building(customer_id)
    employee_id = rand(1..Employee.count)
    employee = Employee.find(employee_id)

    building_types = ['residential', 'corporate', 'commercial', 'hybrid']
    building_id = Building.create({
        "customer_id": customer_id,
        "address_id": rand(1..Address.count),
        "full_name_admin_person": "#{formated(employee.first_name)} #{formated(employee.last_name)}" ,
        "email_admin_person": Faker::Internet.email,
        "building_type": building_types[Faker::Number.within(range: 0..3)],
        "phone_number_admin_person": Faker::PhoneNumber.phone_number,
        "full_name_tech_person": formated(Faker::Name.first_name + " " + Faker::Name.last_name),
        "email_tech_person": Faker::Internet.email,
        "floors": Faker::Number.within(range: 15..60),
        "phone_number_tech_person": Faker::PhoneNumber.phone_number,
        "created_at": "2012-09-10",
        "updated_at": "1987-06-15"
    }).id

    rand(1..5).times do
        seed_battery(building_id)
    end
end

# # # CUSTOMERS
def seed_customers(customers)
    customers.each do |customer|
        ap "CUSTOMERS"
        customer_email = Faker::Internet.email
        address_id = rand(1..Address.count)
        user_id = User.create({"email": customer_email, "password": "12345678", "password_confirmation": "12345678" }).id

        customer_id = Customer.create({
            "address_id": address_id,
            "user_id": user_id,
            "date_of_creation": Faker::Date.between(from: 70.years.ago, to: Date.today),
            "company_name": formated(Faker::Company.name),
            "full_name_contact_person": formated(Faker::Name.first_name + " " + Faker::Name.last_name),
            "phone_number_contact_person": Faker::PhoneNumber.phone_number,
            "email_contact_person": customer_email,
            "company_description": Faker::Company.industry,
            "full_name_service_person": formated(Faker::Name.first_name + " " + Faker::Name.last_name),
            "phone_number_service_person": Faker::PhoneNumber.phone_number,
            "email_service_person": Faker::Internet.email,
            "created_at": "2017-10-20",
            "updated_at": "1987-06-02"
        }).id

        rand(1..5).times do
            seed_building(customer_id)
        end
    end
end

# # # INTERVENTIONS
def seed_Interventions(customer_id)
    ap "INTERVENTION"
    customer = Customer.find(customer_id)
    building = customer.buildings.sample
    intervention_element_id_type = ["battery_id", "column_id", "elevator_id"].sample
    intervention_element_id = nil

    if intervention_element_id_type == "battery_id"
        intervention_element_id = building.batteries.sample.id
    elsif intervention_element_id_type == "column_id"
        intervention_element_id = building.columns.sample.id
    else
        intervention_element_id = building.elevators.sample.id
    end

    intervention = Intervention.new do |i|
        i["author_id"] = rand(1..Employee.count)
        i["employee_id"] = rand(1..Employee.count)
        i["customer_id"] = customer.id
        i["building_id"] = building.id
        i["report"] = Faker::Lorem.sentence()
        i[intervention_element_id_type] = intervention_element_id
    end

    intervention.save!
end


# CUSTOMERS
customers = JSON.parse(File.read('lib/seed/customer.js'))
seed_customers(customers)

# INTERVENTION
50.times do
    customer_id = rand(1..Customer.count)
    seed_Interventions(customer_id)
end


# META WEBSITE PORTFOLIO AND AWARDS
JSON.parse(File.read('lib/seed/awards.js'))
.each do |award|
    Award.create({building_type: award[0], building_name: award[1], building_file: award[2]});
end

# META WEBSITE NEWS
JSON.parse(File.read('lib/seed/news.js'))
.each do |new|
    New.create({ link_src: new[0], image_src: new[1], title: new[2], p: new[3]})
end

# META WEBISTE CLIENTS
JSON.parse(File.read('lib/seed/clients.js'))
.each do |client|
    Client.create({image_src: client[0], name: client[1]})
end

# META WEBSITE NAVS
JSON.parse(File.read('lib/seed/navs.js'))
.each do |nav|
    Nav.create({title: nav[0], id_name: nav[1]})
end