# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include ExceptionHandler
  include RenderResponse
  include PaginationHandler
  include Utils::LocationLogger

  attr_reader :current_user

  def authenticate_user!
    @current_user = nil
  end
end
