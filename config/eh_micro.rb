require 'eh_micro'
require 'json'
require 'active_support/core_ext/string'

EhMicro.configure do |config|
  root_path = File.expand_path('../', __dir__)
  app = JSON.parse(File.read("#{root_path}/app.json"))
  config.version = app['version']
  config.service_name = app['name'].underscore

  config.monitoring = {
    kafka_topics: [
      'EmploymentHero.Agreement'
    ]
  }
  # Uncomment it if using sidekiq
  # config.background_job = :sidekiq

  # Uncomment it if using actionmailer
  # config.mailer = true
  config.bug_tracker = :sentry
end
