require 'dotenv/load'

ENV['APP_ENV'] ||= 'development'
app_env = ENV['APP_ENV']
Dotenv.load(".env.#{app_env}") if File.exist?(".env.#{app_env}")
