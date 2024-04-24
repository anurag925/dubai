# frozen_string_literal: true

# handles all exceptions going out of the controller
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :standard_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from JWT::ExpiredSignature, with: :unauthorized_request
    rescue_from JWT::DecodeError, with: :unauthorized_request
    # rescue_from ActionController::ParameterMissing, with: :parameter_missing
    # ActionController::ParameterMissing
    # rescue_from CanCan::AccessDenied, with: :unauthorized_request
  end

  private

  def parameter_missing
    i18n_msg = 'Required parameter missing'
    render json: failure(msg: i18n_msg, error_code: 'required_params_missing'), status: :forbidden
  end

  def record_not_found
    i18n_msg = 'Record does not exists'
    render json: failure(msg: i18n_msg, error_code: 'record_not_found'), status: :not_found
  end

  def standard_error(err)
    Rails.logger.error("unexpected error err: #{err}, backtrace #{err.backtrace}")
    i18n_msg = 'something went wrong'
    render json: failure(msg: i18n_msg, error_code: 'standard_error'), status: :internal_server_error
  end

  def forbidden
    i18n_msg = 'something went wrong'
    render json: failure(msg: i18n_msg, error_code: 'invalid_request'), status: :forbidden
  end

  def unauthorized_request
    i18n_msg = 'unauthorized'
    render json: failure(msg: i18n_msg, error_code: 'unauthorized'), status: :unauthorized
  end
end
