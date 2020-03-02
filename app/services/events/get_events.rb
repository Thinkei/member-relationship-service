module Services
  module Event
    class GetEvents < BaseService
      def self.call
        new.call
      end

      def call
        ::Event.limit(20).all
      end
    end
  end
end
