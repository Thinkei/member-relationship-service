require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/required_params'
require 'sinatra/custom_logger'
require 'sinatra/namespace'
require 'sinatra/reloader'

class ApplicationController < Sinatra::Base
  configure do
    disable :raise_errors
    disable :show_exceptions
    helpers Sinatra::CustomLogger
    helpers Sinatra::RequiredParams
    helpers Helpers::JSONResponseHelper

    use Rack::Parser, content_types: {
      'application/json' => proc { |body| ::MultiJson.decode body }
    }

    set :logger, EhMicro::Log.logger
    set :logging, true

    register Sinatra::Namespace
  end

  configure :development do
    register Sinatra::Reloader
  end

  before do
    # Sinatra insert values with key "captures" into params when we use "before"
    # hook. It is weird and we could not do anything elese
    params.delete(:captures)
  end

  error do |e|
    status 422
    render_error(
      reason: CustomError::Codes::INVALID_ARGUMENT,
      message: e.message
    )
  end
end
