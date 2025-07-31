# Override database tasks to do nothing since we don't use a database
namespace :db do
  desc "Skip database setup"
  task test: :environment do
    puts "Skipping database setup - no database needed"
  end

  desc "Skip database prepare"
  task test_prepare: :environment do
    puts "Skipping database prepare - no database needed"
  end

  desc "Skip database load config"
  task load_config: :environment do
    puts "Skipping database load config - no database needed"
  end
end
