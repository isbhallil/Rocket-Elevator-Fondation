namespace :pg do |ns|

    task :reset do
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke
      Rake::Task["db:seed"].invoke
    end

    task :drop do
      Rake::Task["db:drop"].invoke
    end

    task :create do
      Rake::Task["db:create"].invoke
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
end