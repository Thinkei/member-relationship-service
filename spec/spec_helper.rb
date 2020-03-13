ENV['APP_ENV'] ||= 'test'

# Setup new database
require 'require_all'
require 'byebug'
require 'database_cleaner'
require 'faker'
require 'rspec/collection_matchers'
require 'rack/test'
require_all 'spec/helpers'
require_relative '../config/environment'

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
