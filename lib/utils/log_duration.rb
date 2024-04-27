# frozen_string_literal: true

module Utils
  # module used for logging the duration of a block
  module LogDuration
    extend ActiveSupport::Concern
    # Log before and after its block
    # with a message and the given params
    def log_duration(message, *_args)
      start_time = Time.current
      Rails.logger.info("#{message} - start time #{start_time}")
      result = yield
    ensure
      end_time = Time.current
      duration = end_time - start_time
      Rails.logger.info("#{message} - end time #{end_time},  duration (#{duration}s)")
      result
    end

    included do
      def self.log_duration(*methods)
        methods.each do |name|
          define_method("#{name}_with_logging") do |*args, &block|
            log_duration("#{self.class.name}##{name}", *args) do
              send("#{name}_without_logging", *args, &block)
            end
          end

          alias_method "#{name}_without_logging", name
          alias_method name, "#{name}_with_logging"
        end
      end
    end
  end
end
