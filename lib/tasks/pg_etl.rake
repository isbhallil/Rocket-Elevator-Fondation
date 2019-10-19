require "pg"

namespace :pg do

    # INITIALIZE CONNECTION FOR ALL TASKS
    warehouse = PG::Connection.open(host: "codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com", port: 5432, dbname: "pg_dev", user: "codeboxx", password: "Codeboxx1!")

    desc "export to pg"
    task etl: :environment do

        ap "RAKE:ETL"
        # FACT_QUOTES
        Quote.all.each do |quote|
            ap quote
            result = warehouse.exec("SELECT * FROM fact_quotes WHERE quote_id = '#{quote.id}'");
            ap result.values.length == 0

            if result.values.length == 0
                ap `INSERT`
                warehouse.exec("INSERT INTO fact_quotes (quote_id, submited_at, elevators_count)
                VALUES ('#{quote.id}', '#{quote.created_at}',  '#{quote.elevator_shafts}') ;")
            else
                ap `UPDATE`
                warehouse.exec("UPDATE fact_quotes SET elevators_count = '#{quote.elevator_shafts}' WHERE quote_id = '#{quote.id}' ;")
            end

        end

        # FACT CUSTOMERS
        Lead.all.each do |lead|
                ap "========================="
                ap "LEAD ===================="
                ap "========================="

                ap lead

                result = warehouse.exec("SELECT * FROM fact_contacts WHERE contact_id = '#{lead.id}'");
                ap "========================="
                ap result.values.length
                ap "========================="
                if result.values.length == 0
                    ap "INSERT"
                    warehouse.exec("INSERT INTO fact_contacts (contact_id, creation_date, company_name, email, project_name)
                                    VALUES ( #{lead.id}, '#{lead.created_at}',  '#{lead.business_name}', '#{lead.email}', '#{lead.building_project_name}')")
                else
                    ap "UPDATE"
                    warehouse.exec("UPDATE fact_contacts SET company_name = '#{lead.business_name}', email = '#{lead.email}', project_name = '#{lead.building_project_name}';")
                end
        end

        # FACT ELEVATORS
        Elevator.all.each do |elevator|
            result = warehouse.exec("SELECT * FROM fact_elevators  WHERE elevator_id = '#{elevator.id}'")
            building = elevator.column.battery.building

            if result.values.length == 0
                ap "INSERT"
                warehouse.exec("INSERT INTO fact_elevators (elevator_id, serial_number, commissioning, building_id, customer_id, city)
                                VALUES ( '#{elevator.id}', '#{elevator.serial_number}',  '#{elevator.date_of_installation}', '#{building.id}',  '#{building.customer.id}'  ,'#{building.address.city}')")
            else
                ap "UPDATE"
                warehouse.exec("UPDATE fact_elevators SET commissioning = '#{elevator.date_of_installation}' ,building_id = '#{building.id}', customer_id = '#{building.customer.id}' , city = '#{building.address.city}'  ;")
            end

        end

        # DIM CUSTOMERS
        Customer.all.each do |customer|
            elevators = 0
            ap "START ======================================================"
            buildings = Building.where(:customer_id => customer.id)
            buildings.each do |building|
                b = Battery.where(:building_id => building.id)
                b.each do |battery|
                    c = Column.where(:battery_id => battery.id)
                    c.each do |column|
                        e = Elevator.where(:column_id => column.id)
                        elevators += e.length
                    end
                end
            end
            ap "ELEVATOR========================"
            ap elevators
            ap "END ========================================================"

            result = warehouse.exec("SELECT * FROM dim_customers WHERE customer_id = '#{customer.id}'");
            ap "VALUES ('#{customer.id}, #{customer.created_at}', '#{customer.company_name}', #{customer.full_name_contact_person.to_s}, '#{customer.email_contact_person}', '#{elevators}', '#{customer.address.city}')"
            if result.values.length == 0
                ap "INSERT"
                warehouse.exec("
                    INSERT INTO \"dim_customers\" (customer_id, creation_date, company_name, full_name, email, elevators_count, city)
                    VALUES ('#{customer.id}', '#{customer.created_at}', '#{customer.company_name}', #{customer.full_name_contact_person.to_s}, '#{customer.email_contact_person}', '#{elevators}', '#{customer.address.city}')
                ;");
            else
                ap "UPDATE"
                warehouse.exec("UPDATE dim_customers SET
                     company_name = '#{customer.company_name}',
                     full_name = '#{customer.full_name_contact_person}',
                     email = '#{customer.email_contact_person}',
                     elevators = '#{elevators}',
                     city = '#{customer.address.city}'
                ;");
            end

        end
    end
end

  # batteries.each do |battery|
            #     columns.push(Column.where(:battery_id => battery.id))
            # end

            # ap buildings

            # customerElevatorsLists = Elevator.select(:id).where(:column_id => Column.where(:battery_id => Battery.where(:building_id => Building.where(:customer_id => customer.id ))))

            # customerElevatorsLists.each do |customerElevatorsList|
            #     result = warehouse.exec("SELECT * FROM dim_customers WHERE customer_id = `#{customer.id}`")
            #     ap customer.id
            #     ap result.values
            #     ap "======================================================"


                # if result.values.length == 0
                #     ap "INSERT"
                #     warehouse.exec("INSERT INTO ")
                # end
                # if customerElevatorsLists.values.lenght == 0

            # end
            #