require 'bcrypt'
require 'devise'
require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

awards = [
    [
        'corporate',
        'burj khalifa',
        'burj-khalifa'
    ],
    [
        'residential',
        'immeuble roussin',
        'residential-1'
    ],[
        'award',
        'speed award nominee',
        'award1-fastest'
    ],[
        'award',
        'emergency award nominee',
        'award3-emergency'
    ],[
        'residential',
        'immeuble latulipe',
        'residential-2'
    ],[
        'corporate',
        'eiffel tower',
        'eiffel-tower'
    ],[
        'award',
        'software elevators award nominee',
        'award2-techno'
    ],[
        'residetial',
        'immeuble lb9',
        'residential-3'
    ],[
        'corporate',
        'centre videotron',
        'centre-videotron'
    ],[
        'residential',
        'le quartier vision',
        'residential-4'
    ],[
        'corporate',
        'the us pentagone',
        'pentagone'
    ],[
        'corporate',
        'empire state building',
        'empire-state-building'
    ]
    
]

awards.each do |award|
    Award.create({building_type: award[0], building_name: award[1], building_file: award[2]});
end

news =  [
    [
        "https://www.theguardian.com/commentisfree/2019/sep/05/new-york-fear-elevators",
        "https://i.guim.co.uk/img/media/11cbf448606a7ebca2e5fbc55bb7598ce8fbef22/0_231_6000_3600/master/6000.jpg?width=300&quality=85&auto=format&fit=max&s=833c8722e0c1dfdc52038f7fe30512f7",
        "Rocket Elevators Launch in Europe",
        "Europe is a new market. We, as a Team, will begin to provide our expertise in Paris, Berlin and London"
    ],[
        "https://www.producer.com/2019/09/ph-to-buy-louis-dreyfus-elevators/",
        "https://d31029zd06w0t6.cloudfront.net/wp-content/uploads/sites/54/2019/09/web1_Schroeder-Lee-RGB.jpg",
        "Thanks to Mr. Price",
        "The CEO of Rocket Elevators will pursuit his dreams to fly in the sky, say welcome to the new one coming"
    ],[
        "https://www.barrons.com/articles/otis-elevator-stock-united-technologies-split-51567546279",
        "assets/david.jpg",
        "Say Hi to the new CEO !",
        "As Mr Price has gone to the jungle we found a precious leader for the company. He has vision and leadership !"
    ],[
        "https://ny.curbed.com/2019/9/4/20849423/nycha-elevators-public-housing-city-council",
        "assets/mohammed.jpg",
        "New Employee of the month",
        "Yet another round of applause the Mohammed. He repeatedly ranked on top players in his duty at work"
    ],[
        "https://www.businessinsider.com/report-after-elevator-crushes-man-nyc-tenant-rent-strike-2019-9",
        "https://amp.businessinsider.com/images/5d6e75e32e22af71fc7f68f3-1334-1001.jpg",
        "New Tech in Elevators Industries, patented by Rocket Rlrvators",
        "A new way to climb stories, meet our teleportation portal. Launch in 2025"
    ],[
        "https://famousbusinessman.com/2019/09/08/global-residential-elevators-market-2/",
        "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/space-elevator-1567182025.jpg?resize=3840:*",
        "New Patent By RocketElevators",
        "We can now send good to the ISS. New Elevators that can go in space !"   
    ]
]

news.each do |new|
    New.create({ link_src: new[0], image_src: new[1], title: new[2], p: new[3]})
end

clients =  [
    [
        "https://cdn.worldvectorlogo.com/logos/iata-1.svg",
        "iata"
    ],[
        "https://cdn.worldvectorlogo.com/logos/emmis-communications.svg",
        "ammis"
    ],[
        "https://cdn.worldvectorlogo.com/logos/hunkemoller.svg",
        "hunkmoller"
    ],[
        "https://cdn.worldvectorlogo.com/logos/klm-4.svg",
        "kim"
    ],[
        "https://cdn.worldvectorlogo.com/logos/boiron-27692.svg",
        "boiron"
    ],[
        "https://cdn.worldvectorlogo.com/logos/au-la-plata-buenos-aires.svg",
        "alpba"
    ],[
        "https://cdn.worldvectorlogo.com/logos/designer-shoe-warehouse.svg",
        "dsw"
    ],[
        "https://cdn.worldvectorlogo.com/logos/advanta.svg",
        "advanta"
    ],[
        "https://cdn.worldvectorlogo.com/logos/salling-bank.svg",
        "salling"
    ],[
        "https://cdn.worldvectorlogo.com/logos/buick-5.svg",
        "buick"
    ],[
        "https://cdn.worldvectorlogo.com/logos/sensient.svg",
        "sansient"
    ],[
        "https://cdn.worldvectorlogo.com/logos/decibel-first.svg",
        "decbel"
    ]
]

clients.each do |client|
    Client.create({image_src: client[0], name: client[1]})
end

navs =  [
    ["home", "top"],
    ["services", 'services'],
    ['portfolio', 'awards-projects'],
    ['news', 'news'],
    ['clients', 'clients'],
    ['contact', 'contact']
]

navs.each do |nav|
    Nav.create({title: nav[0], id_name: nav[1]})
end


user_id_array =[*1..999]

csv_text = File.read(Rails.root.join('lib', 'seed', 'employee.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1:utf-8')
    puts '***EMPLOYEES***'
    csv.each do |row|   
        t = Employee.new
        # t.id = row['Id']
        t.user_id = user_id_array.sample
        t.first_name = row['first_name']
        t.last_name = row['last_name']
        t.title = row['title']
        t.email = row['email']
        t.encrypted_password = row['encrypted_password']
        t.created_at = row['created_at']
        t.updated_at = row['updated_at']
        ap t
        t.save!
                
    end
        puts '***EMPLOYEES COMPLETED***'




csv_text = File.read(Rails.root.join('lib', 'seed', 'address.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|

    puts "Address #{row['id']}==================================================="
        
        #  existing_address = Address.find(row['id'])

        #  unless existing_address

            t = Address.new
            t.id = row['id']
            t.address_type = row['address_type']
            t.status = row['status']
            t.entity = row['entity']
            t.number_street = row['number_street']
            t.apt_number = row['apt_number']
            t.city = row['city']
            t.postal_code = row['postal_code']
            t.country = row['country']
            t.notes = row['notes']
            t.created_at = row['created_at']
            t.updated_at = row['updated_at']
            ap t
            t.save!

        end

    puts '===================================================  Address'
        
#  end  

puts "ADDRESS COMPLETED"



csv_text = File.read(Rails.root.join('lib', 'seed', 'customer.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
puts '***CUSTOMER***'
csv.each do |row|   
    t = Customer.new
    t.user_id = user_id_array.sample
    t.address_id = row['address_id']
    t.date_of_creation = row['date_of_creation']
    t.company_name = row['company_name']
    t.full_name_contact_person = row['full_name_contact_person']
    t.phone_number_contact_person = row['phone_number_contact_person']
    t.email_contact_person = row['email_contact_person']
    t.company_description = row['company_description']
    t.full_name_service_person = row['full_name_service_person']
    t.phone_number_service_person = row['phone_number_service_person']
    t.email_service_person = row['email_service_person']
    t.created_at = row['created_at']
    t.updated_at = row['updated_at']
    t.save!   
end   

puts '***CUSTOMER COMPLETED***'




csv_text = File.read(Rails.root.join('lib', 'seed', 'building.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
puts '***BUILDING***'
    csv.each do |row|
    t = Building.new   
    t.id = row['id']
    t.address_id = row['address_id']
    t.customer_id = row['customer_id']
    t.full_name_admin_person = row['full_name_admin_person']
    t.email_admin_person = row['email_admin_person']
    t.phone_number_admin_person = row['phone_number_admin_person']
    t.full_name_tech_person = row['full_name_tech_person']
    t.email_tech_person = row['email_tech_person']
    t.phone_number_tech_person = row['phone_number_tech_person']
    t.created_at = row['created_at']
    t.updated_at = row['updated_at']
    t.save!
        
        
end  

puts '***BUILDING COMPLETED***'




csv_text = File.read(Rails.root.join('lib', 'seed', 'buildingdetail.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
puts '***BUILDING***'
csv.each do |row| 
    t = BuildingDetail.new  
    t.building_id = row['building_id']
    t.info_key = row['info_key']
    t.value = row['value']
    t.created_at = row['created_at']
    t.updated_at = row['updated_at']
    t.save!
        
        
end 
puts '***BUILDING Details***'

employee_id_array =[*1..59]
building_id_array =[*1..100]

csv_text = File.read(Rails.root.join('lib', 'seed', 'battery.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
puts '***BATTERY***'
csv.each do |row|   
    t = Battery.new
    t.id = row['Id']
    t.building_id = building_id_array.sample
    t.employee_id = employee_id_array.sample
    t.building_type = row['building_type']
    t.status = row['status']
    t.date_of_installation = Date.strptime(row['date_of_installation'], '%m/%d/%Y')
    t.date_of_inspection = Date.strptime(row['date_of_inspection'], '%m/%d/%Y')
    t.inspection_certificate = row['inspection_certificate']
    t.information = row['information']
    t.notes = row['notes']
    t.created_at = row['created_at']
    t.updated_at = row['updated_at']
    t.save!
    
    
end
puts '***BATTERY COMPLETED***'

    battery_id_array =[*1..100]
    floor_number_array =[*1..125]
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv_text = File.read(Rails.root.join('lib', 'seed', 'column.csv'))
    puts '***COLUMN***'
    csv.each do |row| 
        t = Column.new  
        t.battery_id = battery_id_array.sample
        t.building_type = row['building_type']
        t.floor_number = floor_number_array.sample
        t.status = row['status']
        t.information = row['information']
        t.notes = row['notes']
        t.created_at = row['created_at']
        t.updated_at = row['updated_at']
        ap t
        t.save!
        
        
end
puts '***COLUMN COMPLETED***'


csv_text = File.read(Rails.root.join('lib', 'seed', 'elevator.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
puts '***ELEVATOR***'
csv.each do |row|   
    t = Elevator.new
    t.id = row['Id']
    t.column_id = row['column_id']
    t.serial_number = row['serial_number']
    t.model_type = row['model_type']
    t.building_type = row['building_type']
    t.status = row['status']
    t.date_of_installation = Date.strptime(row['date_of_installation'], '%m/%d/%Y')
    t.date_of_inspection = Date.strptime(row['date_of_inspection'], '%m/%d/%Y')
    t.inspection_certificate = row['inspection_certificate']
    t.information = row['information']
    t.notes = row['notes']
    t.created_at = row['created_at']
    t.updated_at = row['updated_at']
    ap t
    t.save!
            
end
    puts '***ELEVATOR COMPLETED***'

  

    
    


