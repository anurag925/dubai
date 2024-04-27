# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
module Utils
  # short form logger to keep track of the log
  module LocationLogger
    def log_location(extra = nil, level = :i, logger_file: nil, caller: nil)
      callloc    = caller || caller_locations(1, 1).first
      log_string = "#{self.class.name}##{callloc.label}:#{callloc.lineno}"
      log_string += " => #{extra}" if extra

      levels = {
        d: :debug,
        i: :info,
        w: :warn,
        e: :error,
        f: :fatal,
        u: :unknown
      }

      logger = logger_file || Rails.logger
      logger.send(levels[level] || :info, log_string)

      extra
    end

    alias lol log_location
  end
end

# rubocop:enable Metrics/MethodLength
