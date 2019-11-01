require "pg"

namespace :pg do


    desc "extract-transform-load to pg"
    task etl: :environment do
        ap "EXTRACT :> TRANSFORM :> LOAD PROCESS START ================================="

        # INITIALIZE CONNECTION FOR ALL TASKS
        # warehouse = PG::Connection.open(host: "codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com", port: 5432, dbname: "GabrielBibeau", user: "codeboxx", password: "Codeboxx1!")
        warehouse = PG::Connection.open(host: "localhost", port: 5432, dbname: "pg_dev", user: "postgres", password: "test")

        # FACT_QUOTES
        ap "ETL :> FACTQUOTES ========================================================="
        Quote.all.each do |quote|
            result = warehouse.exec("SELECT * FROM fact_quotes WHERE quote_id = '#{quote.id}'");

            if result.values.length == 0
                ap `INSERT ETL with ` + quote.inspect
                warehouse.exec("INSERT INTO fact_quotes (quote_id, submited_at, elevators_count)
                VALUES (#{quote.id}, '#{quote.created_at}',  #{quote.elevator_shafts}) ;")
            else
               # ap `UPDATE ETL with ` + quote.inspect
                warehouse.exec("UPDATE fact_quotes SET
                    elevators_count = '#{quote.elevator_shafts}'
                    WHERE quote_id = #{quote.id}
                ;")
            end
        end
        ap "========================================================= ETL :> FACTQUOTES "
        5.times do ap "" end



        # FACT CUSTOMERS
        ap "ETL :> FACTCONTACTS ========================================================="
        Lead.all.each do |lead|

                result = warehouse.exec("SELECT * FROM fact_contacts WHERE contact_id = '#{lead.id}'");
                if result.values.length == 0
                    ap "INSERT ETL with " + lead.inspect
                    warehouse.exec("INSERT INTO fact_contacts (contact_id, creation_date, company_name, email, project_name)
                                    VALUES ( #{lead.id}, '#{lead.created_at}',  '#{lead.business_name}', '#{lead.email}', '#{lead.building_project_name}')")
                 else
                     ap "UPDATE ETL with " + lead.inspect
                     warehouse.exec("UPDATE fact_contacts SET
                         company_name = '#{lead.business_name}',
                         email = '#{lead.email}',
                         project_name = '#{lead.building_project_name}'
                         WHERE contact_id = '#{contact.id}'
                     ;")
                end
        end
        ap "========================================================= ETL :> FACTQUOTES "
        5.times do ap "" end



        # FACT ELEVATORS
        ap " ETL :> FACTELEVATORS ========================================================="
        Elevator.all.each do |elevator|
            result = warehouse.exec("SELECT * FROM fact_elevators  WHERE elevator_id = '#{elevator.id}'")
            building = elevator.column.battery.building

            if result.values.length == 0
                ap "INSERT ETL with " + elevator.inspect
                warehouse.exec("INSERT INTO fact_elevators (elevator_id, serial_number, commissioning, building_id, customer_id, city)
                                VALUES ( #{elevator.id}, '#{elevator.serial_number}',  '#{elevator.date_of_installation}', #{building.id},  #{building.customer.id}, '#{building.address.city}')")
            else
                ap "UPDATE ETL with " + elevator.inspect
                warehouse.exec("UPDATE fact_elevators SET
                    commissioning = '#{elevator.date_of_installation}' ,
                    building_id = #{building.id},
                    customer_id = #{building.customer.id} ,
                    city = '#{building.address.city}'
                    WHERE elevator_id = #{elevator.id}
                ;")
            end
        end
        ap "========================================================= ETL :> FACTELEVATORS "
        5.times do ap "" end



        # DIM CUSTOMERS
        ap "ETL :> DIM CUSTOMERS ========================================================= "
        Customer.all.each do |customer|
            customerElevatorsLists = Elevator.where(:column_id => Column.where(:battery_id => Battery.where(:building_id => Building.where(:customer_id => customer.id ))))
            result = warehouse.exec("SELECT * FROM dim_customers WHERE customer_id = '#{customer.id}'");



            if result.values.length == 0
                ap "INSERT ETL with " + customer.inspect
                warehouse.exec("
                    INSERT INTO dim_customers (
                        customer_id, creation_date, company_name, full_name, email, elevators_count, city)
                    VALUES (
                        #{customer.id},
                        '#{customer.created_at}',
                        '#{customer.company_name}',
                        #{customer.full_name_contact_person},
                        '#{customer.email_contact_person}',
                        #{customerElevatorsLists.count},
                        '#{customer.address.city}'
                    )
                ;")
            else
                ap "UPDATE ETL with " + customer.inspect
                warehouse.exec("UPDATE dim_customers SET
                     company_name = '#{customer.company_name}',
                     full_name = #{customer.full_name_contact_person},
                     email = '#{customer.email_contact_person}',
                     elevators_count = #{customerElevatorsLists.count},
                     city = '#{customer.address.city}'
                     WHERE customer_id = #{customer.id}
                ;");
            end
        end

        ap "========================================================= ETL :> DIMCUSTOMERS "
        5.times do ap "" end



        warehouse.finish
        ap "EXTRACT :> TRANSFORM :> LOAD PROCESS COMPLETE ================================="
    end
end

