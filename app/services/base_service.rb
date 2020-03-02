module Services
  class BaseService
    include EhMicro::Log

    def errors
      @errors ||= []
    end

    def success?
      errors.empty?
    end

    protected

    def log_errors(err)
      info = { class_name: self.class.to_s }
      logger.error("Exception in #{self.class}: #{err}")
      logger.error("Request: #{info}")
      Raven.capture_exception(err, extra: { request: info })
    end
  end
end
