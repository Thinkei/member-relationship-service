source 'http://rubygems.org'

gem 'dotenv'
gem 'karafka'
gem 'pg', '~>0.20.0'
gem 'puma'
gem "rack", ">= 2.0.6"
gem 'rack-cors', require: 'rack/cors'
gem 'rack-parser', require: 'rack/parser'
gem 'rake'
gem 'require_all'
gem 'ruby-kafka'
gem 'sentry-raven'
gem 'sequel'
gem 'sinatra'
gem 'sinatra-contrib', require: false

source 'https://gem.fury.io/eh-devops/' do
  gem 'eh_micro', '0.1.2'
  gem 'eh_monitoring'
end

group :test do
  gem 'database_cleaner'
  gem 'rack-test'
  gem 'rspec'
  gem 'rspec-collection_matchers'
  gem 'rspec_junit_formatter'
  gem 'faker'
end

group :development do
  gem 'tux'
end

group :development, :test do
  gem 'byebug'
  gem 'danger'
  gem 'danger-commit_lint'
  gem 'danger-rubocop', '0.6.0', require: false
  gem 'danger-simplecov_json'
  gem 'pry-byebug'
  gem 'rubocop', '0.53.0', require: false
end
