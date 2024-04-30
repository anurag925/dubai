# frozen_string_literal: true

# base class for all services
class ApplicationService
  include Utils::LocationLogger
  include Utils::LogDuration
  include Utils::SoulSaver

  Response = Struct.new(:success?, :msg, :data, :code)

  class << self
    def call(*)
      new(*).call
    end
  end

  # method returns success from a given service
  # @param msg [String]
  # @param data [Any]
  # @returns [Response]
  def success(msg: '', data: {})
    Response.new(true, msg, data)
  end

  # method returns error from a given service
  # @param msg [String]
  # @param data [Any]
  # @param code [String]
  # @returns [Response]
  def error(msg: '', data: {}, code: '')
    Response.new(false, msg, data, code)
  end

  def alert!(message, code: '', extra: {})
    sos(message, code:, extra:, caller: caller_locations(1, 1).first)
    lol("#{message} extra: #{extra.inspect}", :e, caller: caller_locations(1, 1).first)
  end
end
