# frozen_string_literal: true

ENV['APP_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['APP_ENV']
Bundler.require(:default, ENV['KARAFKA_ENV'])
require_rel './config/environment'
Karafka::Loader.load(Karafka::App.root)

class ConsumerMapper
  def self.call(raw_consumer_group_name)
    [
      Karafka::App.config.client_id,
      raw_consumer_group_name
    ].join('.')
  end
end

ENV['KAFKA_BROKERS'] ||= '127.0.0.1:9092'

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = [ENV['KAFKA_BROKERS']].map { |x| "kafka://#{x}" }
    config.consumer_mapper = ConsumerMapper

    if ENV['KAFKA_CA_FILE']
      config.kafka.ssl_ca_cert = File.read ENV['KAFKA_CA_FILE']
      config.kafka.ssl_client_cert = File.read ENV['KAFKA_CERT_FILE']
      config.kafka.ssl_client_cert_key = File.read ENV['KAFKA_CERT_KEY_FILE']
    else
      config.kafka.ssl_ca_cert = ENV['KAFKA_CA']
      config.kafka.ssl_client_cert = ENV['KAFKA_CERT']
      config.kafka.ssl_client_cert_key = ENV['KAFKA_CERT_KEY']
    end

    config.client_id = EhMicro.config.service_name
    config.backend = :inline
    config.batch_fetching = true
    config.logger = EhMicro::Log.logger
  end

  after_init do |config|
    # Put here all the things you want to do after the Karafka framework
    # initialization
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  Karafka.monitor.subscribe(Karafka::Instrumentation::Listener)

  consumer_groups.draw do
    topic 'EmploymentHero.Agreement' do
      consumer AgreementConsumer
      batch_consuming true
      parser Karafka::Parsers::Json
    end
  end
end

KarafkaApp.boot!
