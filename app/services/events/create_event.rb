module Services
  module Event
    class CreateEvent < BaseService
      def self.call
        new.call
      end

      FIELDS = %i[
        topic
        event
        parser
        partition
        offset
        create_time
        receive_time
        uuid
        event
        data
      ]

      def initialize(params)
        @params = params
      end

      def call
        event = ::Event.new
        event.set_fields(@params, FIELDS)
        event.save(raise_on_save_failure: true)
      rescue Sequel::Error => e
        errors << "Can not create event"
        log_errors e
      end
    end
  end
end
