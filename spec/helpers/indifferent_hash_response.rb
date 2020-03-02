module Helpers
  module IndifferentHashResponse
    def last_response_body
      Sinatra::IndifferentHash[JSON.parse(last_response.body)]
    end
  end
end
