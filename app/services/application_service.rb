# frozen_string_literal: true

# base class for all services
class ApplicationService
  Response = Struct.new(:success?, :message, :data, :code)

  class << self
    def call(*)
      new(*).call
    end
  end

  def initialize(_args)
    raise NotImplementedError
  end

  def call
    raise NotImplementedError
  end

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
