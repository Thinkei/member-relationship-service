require './config/environment'
require 'rack'

if %w[production staging].include?(ENV['APP_ENV'])
  use ::Instana::Rack
  use ::Raven::Rack
end

run Rack::Cascade.new [
  # Api::V1::EventsController
  # Add more app as you wish
]
