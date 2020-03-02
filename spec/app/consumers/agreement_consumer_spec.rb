require 'spec_helper'

describe AgreementConsumer do
  subject(:consumer) { described_class.new }

  before do
    consumer.params_batch = [{ 'event' => 'create', 'parsed' => true }]
    allow(Karafka.logger).to receive(:info)
    allow_any_instance_of(
      Services::Event::CreateEvent
    ).to receive(:call)
  end

  it 'expects to create events' do
    expect_any_instance_of(
      Services::Event::CreateEvent
    ).to receive(:call)
    consumer.consume
  end
end
