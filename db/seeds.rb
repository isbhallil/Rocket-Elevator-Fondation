require 'bcrypt'
require 'devise'
require 'csv'

# EMPLOYEES
JSON.parse(File.read('lib/seed/employee.js')).each do |e|
    ap "EMPLOYEE"
    ap e["email"]
    user = User.create!({"email": e["email"], "password": "12345678", "password_confirmation": "12345678" })
    employee = Employee.create({user: user, "first_name": e["first_name"], "last_name": e["last_name"],"title": e["title"], "email": e["email"], "encrypted_password": "12345678"})
end

# ADMINS
JSON.parse(File.read('lib/seed/admin.js')).each do |e|
    ap "ADMIN"
    user = User.create!({"email": e["email"], "password": "12345678", "password_confirmation": "12345678" })
    employee = Employee.create({user: user, "first_name": e["first_name"], "last_name": e["last_name"],"title": e["title"], "email": e["email"], "encrypted_password": "12345678"})
end

# LEAD
JSON.parse(File.read('lib/seed/leads.js')).each do |l|
    ap "LEAD"
    Lead.create({
        "full_name": l["fulle_name"],
        "business_name": l["business_name"],
        "email": l["email"],
        "phone_number": l["phone_number"],
        "building_project_name": l["building_project_name"],
        "project_description": l["project_description"],
        "message": l["message"],
        "department_in_charge_of_elevators": l["department_in_charge_of_elevators"]
    })
end


# ADDRESSES
JSON.parse(File.read('lib/seed/address.js')).each do |a|
    ap "ADDRESS"
    Address.create({
        "status": "Active",
        "entity": "Building",
        "number_street": a["number_street"],
        "apt_number": Faker::Number.between(from: 1, to: 50),
        "city": a["city"],
        "postal_code": a["postalCode"],
        "country": "US",
        "notes": Faker::Lorem.sentence(),
    })
end


# CUSTOMERS
customer_address_ids = [*1..Address.count]
JSON.parse(File.read('lib/seed/customer.js')).each do |c|
    ap "CUSTOMER"
    customer_email = Faker::Internet.email
    customer_address_id = customer_address_ids.sample
    customer_id = Customer.create({
        "address_id": customer_address_ids.delete(customer_address_id),
        "users_id": User.create({"email": customer_email, "password": "12345678", "password_confirmation": "12345678" }).id ,
        "date_of_creation": Faker::Date.between(from: 70.years.ago, to: Date.today),
        "company_name": Faker::Company.name,
        "full_name_contact_person": Faker::Name.first_name + " " + Faker::Name.last_name,
        "phone_number_contact_person": Faker::PhoneNumber.phone_number,
        "email_contact_person": customer_email,
        "company_description": Faker::Company.industry,
        "full_name_service_person": Faker::Name.first_name + " " + Faker::Name.last_name,
        "phone_number_service_person": Faker::PhoneNumber.phone_number,
        "email_service_person": Faker::Internet.email,
        "created_at": "2017-10-20",
        "updated_at": "1987-06-02"
    }).id

    seed_building(customer_id)
end


# BUILDING
building_address_ids = [*1..Address.count]
def seed_building(customer_id)
    Faker::Number.within(range: 1..2).times do
        building_id = Building.create({
            "customer_id": customer_id,
            "address_id": building_address_ids.delete(building_address_ids.sample),
            "full_name_admin_person": "Bianka Willcock",
            "email_admin_person": "smcgillivray2q@1688.com",
            "phone_number_admin_person": "180-299-4973",
            "full_name_tech_person": "Sofie McGillivray",
            "email_tech_person": "smcgillivray2q@bravesites.com",
            "floors": Faker::Number.within(range: 15..60),
            "phone_number_tech_person": "398-455-3175",
            "created_at": "2012-09-10",
            "updated_at": "1987-06-15"
        }).id

        seed_battery(building_id)
    end
end

# BATTERY
def seed_battery(building_id)
    date_of_installation = Faker::Date.between(from: 70.years.ago, to: Date.today)
    date_of_inspection = Faker::Date.backward(days: 14)

    battery_id = Battery.create({
        "building_id": building_id,
        "employee_id": employee_ids[Faker::Number.within(range: 1..Employee.count)],
        "status": "Inactive",
        "date_of_installation": date_of_installation,
        "date_of_inspection": date_of_inspection,
        "inspection_certificate": "Certified",
        "information": Faker::Lorem.sentence(),
        "notes": Faker::Lorem.sentence(),
        "created_at": "11/19/1985",
        "updated_at": "9/3/2008"
    }).id

    Faker::Number.within(range: 1..3).times do
        seed_column(battery_id)
    end
end



# COLUMNS
def seed_column(battery_id)
    statuses = ["On", "Off", "Intervention"]
    Column.create({
        "battery_id": battery_id,
        "status": statuses[Faker::Number.within(range: 0..2)],
        "information": Faker::Lorem.sentence(),
        "notes": Faker::Lorem.sentence(),
        "created_at": "2017-12-26",
        "updated_at": "2017-10-07"
    })

    Faker::Number.within(range: 1..3).times do
        seed_elevator(column_id)
    end
end


# ELEVATORS
def seed_elevator(column_id)
    model_types = ["Standard", "Premium", "Excelium"]
    statuses = ["On", "Off", "Intervention"]
    Elevator.create({
        "column_id": column_id,
        "serial_number": Faker::Alphanumeric.alpha(number: 15),
        "model_type": model_types[Faker::Number.within(range: 0..2)],
        "status": statuses[Faker::Number.within(range: 0..2)],
        "date_of_installation": "3/23/2017",
        "date_of_inspection": "9/17/2018",
        "inspection_certificate": Faker::Alphanumeric.alpha(number: 25),
        "information": Faker::Lorem.sentence(),
        "notes": Faker::Lorem.sentence(),
        "created_at": "1/13/2019",
        "updated_at": "6/8/2017"
    })
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