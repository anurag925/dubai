# frozen_string_literal: true

module Utils
  # takes care of sending errors for keeping track
  module SoulSaver
    def sos(message, code: '', extra: {}, caller: nil)
      callloc = caller || caller_locations(1, 1).first
      caller = "#{self.class.name}##{callloc.label}:#{callloc.lineno}"
      log_string = caller
      log_string += " => #{extra}" if extra

      Rails.logger.error(log_string)
      Error.new(message:, code:, extra:, caller:).save!
      # Raven.capture_message "[#{self.class.name}##{caller_method}] => #{message}",
      #                       extra: extra
    rescue StandardError => e
      Rails.logger.error("Error in SoulSaver #{e.message}, #{e.backtrace}")
    end
  end
end
