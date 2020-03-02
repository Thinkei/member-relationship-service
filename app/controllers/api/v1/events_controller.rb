module Api
  module V1
    class EventsController < ::ApplicationController
      namespace '/api/v1/events' do
        get do
          render_array Services::Event::GetEvents.call
        end
      end
    end
  end
end
