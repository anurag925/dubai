# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ExceptionHandler
  include RenderResponse
  include PaginationHandler
end
