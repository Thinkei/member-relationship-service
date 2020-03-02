ENV['APP_ENV'] ||= 'test'

# Setup new database
require 'require_all'
require_all './config/initializers'
load './lib/tasks/db.rake'
Rake::Task['db:reset'].invoke

def db_query(database = nil)
  logger = Logger.new(STDOUT)
  logger.level = Logger::DEBUG
  db = Sequel.connect(
    adapter: ENV['DATABASE_ADAPTER'] || 'postgres',
    host: ENV['DATABASE_HOST'] || 'localhost',
    port: (ENV['DATABASE_PORT'] || 5432).to_i,
    user: ENV['DATABASE_USR'],
    database: database,
    password: ENV['DATABASE_PWD'],
    logger: logger
  )
  yield db
ensure
  db.disconnect
end

Sequel.extension :migration
db_query do |db|
  begin
    db.run("DROP DATABASE IF EXISTS #{ENV['DATABASE_NAME']}")
    db.run("CREATE DATABASE #{ENV['DATABASE_NAME']}")
  rescue StandardError => _
    puts "Could not setup database automatically. Please setup by yourself"
  end
end
db_query(ENV['DATABASE_NAME']) do |db|
  root_path = File.expand_path('../', __dir__)
  Sequel::Migrator.run(db, "#{root_path}/db/migrations")
end

require_all './config/environment'
require 'byebug'
require 'database_cleaner'
require 'rspec/collection_matchers'
require 'rack/test'
require_all 'spec/helpers'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Helpers::IndifferentHashResponse
  config.order = 'default'

  config.before(:suite) do
    cleaner = DatabaseCleaner[:sequel, { connection: DB }]
    cleaner.strategy = :transaction
    cleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner[:sequel, { connection: DB }].cleaning do
      example.run
    end
  end
end

require './karafka.rb'
