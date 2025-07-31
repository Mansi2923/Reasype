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

  # Add the colon version that CI expects
  desc "Skip database prepare (colon version)"
  task "test:prepare" => :environment do
    puts "Skipping database prepare - no database needed"
  end

  desc "Skip database load config"
  task load_config: :environment do
    puts "Skipping database load config - no database needed"
  end

  desc "Skip database create"
  task create: :environment do
    puts "Skipping database create - no database needed"
  end

  desc "Skip database drop"
  task drop: :environment do
    puts "Skipping database drop - no database needed"
  end

  desc "Skip database migrate"
  task migrate: :environment do
    puts "Skipping database migrate - no database needed"
  end

  desc "Skip database setup"
  task setup: :environment do
    puts "Skipping database setup - no database needed"
  end

  desc "Skip database reset"
  task reset: :environment do
    puts "Skipping database reset - no database needed"
  end

  desc "Skip database seed"
  task seed: :environment do
    puts "Skipping database seed - no database needed"
  end
end
