# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ExceptionHandler
  include RenderResponse
  include PaginationHandler
  include Utils::LocationLogger

  attr_reader :current_user

  def authenticate_user!
    @current_user = nil
  end
end
