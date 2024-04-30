# frozen_string_literal: true

# handles different types of responses from the controller
module RenderResponse
  extend ActiveSupport::Concern
  included do
    alias_method :success, :render_success
    alias_method :failure, :render_failure
  end

  def json_success(msg: '', data: {})
    render json: render_success(msg:, data:), status: :ok
  end

  def json_created(msg: '', data: {})
    render json: render_success(msg:, data:), status: :created
  end

  def json_failure(msg: '', error_code: '', data: {})
    render json: render_failure(msg:, error_code:, data:), status: :bad_request
  end

  def json_unauthorized(msg: '', data: {})
    render json: render_failure(msg:, error_code: :unauthorized, data:), status: :unauthorized
  end

  def json_not_found(msg: '', data: {})
    render json: render_failure(msg:, error_code: 'record_not_found', data:), status: :not_found
  end

  def render_success(msg: '', data: {})
    {
      success: true,
      message: msg,
      data:
    }
  end

  def render_failure(msg: '', error_code: '', data: {})
    {
      success: false,
      message: msg,
      # error_code: errors_code(error_code),
      data:
    }
  end

  def errors_code(error = nil)
    Errors::Handler.code(error)
  end
end
