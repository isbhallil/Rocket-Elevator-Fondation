# require "pg"

# namespace :pg do
#     def formated(string)
#         string.gsub("'","''")
#     end

#     desc "extract-transform-load to pg"
#     task etl: :environment do
#         ap "EXTRACT :> TRANSFORM :> LOAD PROCESS START ================================="

#         # INITIALIZE CONNECTION FOR ALL TASKS
#         # warehouse = PG::Connection.open(host: "codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com", port: 5432, dbname: "GabrielBibeau", user: "codeboxx", password: "Codeboxx1!")
#         warehouse = PG::Connection.open(host: "localhost", port: 5432, dbname: "pg_dev", user: "postgres", password: "test")

#         # FACT_QUOTES
#         ap "ETL :> FACTQUOTES ========================================================="
#         Quote.all.each do |quote|
#             result = warehouse.exec("SELECT * FROM fact_quotes WHERE quote_id = '#{quote.id}'");

#             if result.values.length == 0
#                 ap `INSERT ETL with ` + quote.inspect
#                 warehouse.exec("INSERT INTO fact_quotes (quote_id, submited_at, elevators_count)
#                 VALUES (#{quote.id}, '#{quote.created_at}',  #{quote.elevator_shafts}) ;")
#             else
#                # ap `UPDATE ETL with ` + quote.inspect
#                 warehouse.exec("UPDATE fact_quotes SET
#                     elevators_count = '#{quote.elevator_shafts}'
#                     WHERE quote_id = #{quote.id}
#                 ;")
#             end
#         end
#         ap "========================================================= ETL :> FACTQUOTES "
#         5.times do ap "" end



#         # FACT CUSTOMERS
#         ap "ETL :> FACTCONTACTS ========================================================="
#         Lead.all.each do |lead|

#                 result = warehouse.exec("SELECT * FROM fact_contacts WHERE contact_id = '#{lead.id}'");
#                 if result.values.length == 0
#                     ap "INSERT ETL with " + lead.inspect
#                     warehouse.exec("INSERT INTO fact_contacts (contact_id, creation_date, company_name, email, project_name)
#                                     VALUES ( #{lead.id}, '#{lead.created_at}',  '#{formated(lead.business_name)}', '#{lead.email}', '#{formated(lead.building_project_name)}')")
#                  else
#                      ap "UPDATE ETL with " + lead.inspect
#                      warehouse.exec("UPDATE fact_contacts SET
#                          company_name = '#{formated(lead.business_name)}',
#                          email = '#{lead.email}',
#                          project_name = '#{formated(lead.building_project_name)}'
#                          WHERE contact_id = '#{lead.id}'
#                      ;")
#                 end
#         end
#         ap "========================================================= ETL :> FACTQUOTES "
#         5.times do ap "" end



#         # FACT ELEVATORS
#         ap " ETL :> FACTELEVATORS ========================================================="
#         Elevator.all.each do |elevator|
#             result = warehouse.exec("SELECT * FROM fact_elevators  WHERE elevator_id = '#{elevator.id}'")
#             building = elevator.column.battery.building

#             if result.values.length == 0
#                 ap "INSERT ETL with " + elevator.inspect
#                 warehouse.exec("INSERT INTO fact_elevators (elevator_id, serial_number, commissioning, building_id, customer_id, city)
#                                 VALUES ( #{elevator.id}, '#{elevator.serial_number}',  '#{elevator.date_of_installation}', #{building.id},  #{building.customer.id}, '#{formated(building.address.city)}')")
#             else
#                 ap "UPDATE ETL with " + elevator.inspect
#                 warehouse.exec("UPDATE fact_elevators SET
#                     commissioning = '#{elevator.date_of_installation}' ,
#                     building_id = #{building.id},
#                     customer_id = #{building.customer.id} ,
#                     city = '#{formated(building.address.city)}'
#                     WHERE elevator_id = #{elevator.id}
#                 ;")
#             end
#         end
#         ap "========================================================= ETL :> FACTELEVATORS "
#         5.times do ap "" end

#         # DIM CUSTOMERS
#         ap "ETL :> DIM CUSTOMERS ========================================================= "
#         Customer.all.each do |customer|
#             customerElevatorsLists = Elevator.where(:column_id => Column.where(:battery_id => Battery.where(:building_id => Building.where(:customer_id => customer.id ))))
#             result = warehouse.exec("SELECT * FROM dim_customers WHERE customer_id = '#{customer.id}'");



#             if result.values.length == 0
#                 ap "INSERT ETL with " + customer.inspect
#                 warehouse.exec("
#                     INSERT INTO dim_customers (
#                         customer_id, creation_date, company_name, full_name, email, elevators_count, city)
#                     VALUES (
#                         #{customer.id},
#                         '#{customer.created_at}',
#                         '\"#{formated(customer.company_name)}\"',
#                         '#{customer.email_contact_person}',
#                         '\"#{formated(customer.full_name_contact_person)}\"',
#                         #{customerElevatorsLists.count},
#                         '#{formated(customer.address["city"])}'
#                     )
#                 ;")
#             else
#                 ap "UPDATE ETL with " + customer.inspect
#                 warehouse.exec("UPDATE dim_customers SET
#                      company_name = '\"#{formated(customer.company_name)}\"',
#                      full_name = '\"#{formated(customer.full_name_contact_person)}\"',
#                      email = '#{customer.email_contact_person}',
#                      elevators_count = #{customerElevatorsLists.count},
#                      city = '#{formated(customer.address.city)}'
#                      WHERE customer_id = #{customer.id}
#                 ;");
#             end
#         end

#         ap "========================================================= ETL :> DIMCUSTOMERS "
#         5.times do ap "" end



#         warehouse.finish
#         ap "EXTRACT :> TRANSFORM :> LOAD PROCESS COMPLETE ================================="
#     end

#     desc "seed data on pg-dev.fact_interventions"
#     task interventions: :environment do
#         # INITIALIZE CONNECTION FOR ALL TASKS
#         # warehouse = PG::Connection.open(host: "codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com", port: 5432, dbname: "GabrielBibeau", user: "codeboxx", password: "Codeboxx1!")
#         warehouse = PG::Connection.open(host: "localhost", port: 5432, dbname: "pg_dev", user: "postgres", password: "test")

#         buildings_list = Building.select(
#             :id,
#             "count(batteries.id) as batteries",
#             "count(columns.id) as columns",
#             "count(elevators.id) as elevators"
#         )
#         .joins(:batteries, :columns, :elevators, :customer, :address)
#         .group("buildings.id")

#         def get_intervention(building)
#             ap "GET_INTERVENTION ==================="
#             intervention = {
#                 employeeId: Employee.all.sample.id,
#                 buildingId: building["id"],
#                 result: get_random_from("success", "failure", "incomplete"),
#                 report: Faker::Lorem.paragraph,
#                 status: get_random_from("Pending" ,"InProgress" ,"Interrupted" ,"Resumed" ,"Complete")
#             }

#             get_intervention_type(building).each do |type, value|
#                 intervention[type] = value
#             end

#             get_intervention_timestamps.each do |key, value|
#                 intervention[key] = value
#             end

#             intervention
#         end

#         def get_random_from(*args)
#             ap "GET_RANDOM_FROM ==================="
#             [*args].sample
#         end

#         def get_intervention_timestamps
#             ap "GET_INTERVENTION_TIMESTAMPS ==================="
#             days_of_intervention = [1,2,3,4,5]

#             intervention_begins_at = Faker::Time.between(from: 70.year.ago - 1, to: DateTime.now)
#             intervention_finished_at = Faker::Time.between(from: intervention_begins_at, to: intervention_begins_at + days_of_intervention.sample.days)

#             intervention_time_stamps = {
#                 intervention_begins_at: intervention_begins_at,
#                 intervention_finished_at: intervention_finished_at
#             }

#             intervention_time_stamps
#         end

#         def get_intervention_type(building)
#             ap "GET_INTERVENTION_TYPE ==================="
#             intervention_type = {
#                 battery: nil,
#                 column: nil,
#                 elevator: nil
#             }

#             type_of_intervention = get_random_from('battery', 'column', 'elevator')

#             if type_of_intervention == 'battery'
#                 intervention_type[:battery] = JSON.parse(building.to_json)["batteries"].sample["id"]
#             elsif type_of_intervention == 'column'
#                 intervention_type[:column] = JSON.parse(building.to_json)["columns"].sample["id"]
#             else
#                 intervention_type[:elevator] = JSON.parse(building.to_json)["elevators"].sample["id"]
#             end

#             intervention_type
#         end

#         buildings_list.each do |building|
#             intervention = get_intervention(building)
#             ap "TEST 1"
#             ap intervention
#             ap intervention[:employeeId]
#             warehouse.exec("
#                 INSERT INTO fact_interventions
#                 (
#                     employee_id,
#                     building_id,
#                     battery_id,
#                     column_id,
#                     elevator_id,
#                     intervention_begins_at,
#                     intervention_finished_at,
#                     result,
#                     report,
#                     status
#                 )
#                 VALUES (
#                     '#{intervention[:employeeId].to_i}',
#                     '#{intervention[:buildingId].to_i}',
#                     '#{intervention[:battery].to_i}',
#                     '#{intervention[:column].to_i}',
#                     '#{intervention[:elevator].to_i}',
#                     '#{intervention[:intervention_begins_at]}',
#                     '#{intervention[:intervention_finished_at]}',
#                     '#{intervention[:result]}',
#                     '#{intervention[:report]}',
#                     '#{intervention[:status]}'
#                 )
#             ")
#         end

#         warehouse.finish
#     end
# end