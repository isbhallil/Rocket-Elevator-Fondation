task spec: ["pg:db:test:prepare"]


namespace :pg do |ns|


    task :reset do
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke
    end

    task :drop do
      Rake::Task["db:drop"].invoke
    end

    task :create do
      Rake::Task["db:create"].invoke
    end

    task :setup do
      Rake::Task["db:setup"].invoke
    end

    task :migrate do
      Rake::Task["db:migrate"].invoke
    end

    task :rollback do
      Rake::Task["db:rollback"].invoke
    end

    task :seed do
      Rake::Task["db:seed"].invoke
    end

    task :version do
      Rake::Task["db:version"].invoke
    end

    namespace :schema do
      task :load do
        Rake::Task["db:schema:load"].invoke
      end

      task :dump do
        Rake::Task["db:schema:dump"].invoke
      end
    end

    namespace :test do
      task :prepare do
        Rake::Task["db:test:prepare"].invoke
      end
    end

    # append and prepend proper tasks to all the tasks defined here above
    ns.tasks.each do |task|
      task.enhance ["pg:set_custom_config"] do
        Rake::Task["pg:revert_to_original_config"].invoke
      end
    end
  # end

  task :set_custom_config do
    # save current vars
    @original_config = {
      env_schema: ENV['SCHEMA'],
      config: Rails.application.config.dup
    }

    # set config variables for custom database
    ENV['SCHEMA'] = "pg/schema.rb"
    Rails.application.config.paths['db'] = ["pg"]
    Rails.application.config.paths['db/migrate'] = ["pg/migrate"]
    Rails.application.config.paths['db/seeds'] = ["pg/seeds.rb"]
    Rails.application.config.paths['config/database'] = ["config/warehouse.yml"]
  end

	task :revert_to_original_config do
    # reset config variables to original values
    ENV['SCHEMA'] = @original_config[:env_schema]
    Rails.application.config = @original_config[:config]
  end
  desc 'Force a pg:reset2 of database'
  task hard_reset2: :environment do
    if Rails.env.development?
      conn = ActiveRecord::Base.connection
      # Terminate all connections except our current one
      conn.execute("SELECT
                      pg_terminate_backend (pid)
                    FROM
                      pg_stat_activity
                    WHERE
                      pid <> pg_backend_pid ()
                    AND datname = 'converger_development';")
      # Close the connection behind us
      ActiveRecord::Base.connection.close
# Invoke a task now all connections are gone
      Rake::Task['pg:reset2'].invoke
      Rake::Task['pg:migrate'].invoke
p "Forced a pg:reset2 for environment #{Rails.env}"
    else
      p "Sorry I cannot pg:reset2 pg on this environment: #{Rails.env}"
    end
  end
end