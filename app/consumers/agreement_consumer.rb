class AgreementConsumer < ApplicationConsumer
  def consume
    params_batch.each do |params|
      service = ::Services::Event::CreateEvent.new(
        Sinatra::IndifferentHash.new.merge(params)
      )
      service.call
    end
  end
end
