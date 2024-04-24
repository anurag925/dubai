# frozen_string_literal: true

# handles pagination for the controller
module PaginationHandler
  extend ActiveSupport::Concern
  def page_no
    @page_no ||= (params[:page_no] || 0).to_i
  end

  def invalidate_page_no
    page_no.eql?(-1)
  end

  def per_page
    @per_page ||= (params[:per_page] || 20).to_i
  end
end
