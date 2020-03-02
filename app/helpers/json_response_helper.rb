require 'sinatra/base'

module Helpers
  module JSONResponseHelper
    def render_error(errors)
      errors = [errors] if errors.is_a?(Hash)

      { error: { errors: errors } }.to_json
    end

    def render_array(items)
      { data: { items: items } }.to_json
    end

    def render_item(item)
      { data: item }.to_json
    end
  end
end
