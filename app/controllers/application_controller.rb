# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include ExceptionHandler
  include RenderResponse
  include PaginationHandler
  include AuthorizationHandler
  include Utils::LocationLogger

  attr_reader :current_user
end
