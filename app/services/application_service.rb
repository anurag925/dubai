# frozen_string_literal: true

# base class for all services
class ApplicationService
  include Utils::LocationLogger
  include Utils::LogDuration

  Response = Struct.new(:success?, :message, :data, :code)

  class << self
    def call(*)
      new(*).call
    end
  end

  # method returns success from a given service
  # @param msg [String]
  # @param data [Any]
  # @returns [Resonse]
  def success(msg: '', data: {})
    Response.new(true, msg, data)
  end

  # method returns error from a given service
  # @param msg [String]
  # @param data [Any]
  # @param code [String]
  # @returns [Resonse]
  def error(msg: '', data: {}, code: '')
    Response.new(false, msg, data, code)
  end
end
