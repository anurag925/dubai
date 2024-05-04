# frozen_string_literal: true

module Api
  module V1
    # Controller responsible for showing sales data
    class SalesController < ApplicationController
      before_action :authorize_user!

      def details
        res = Sales::InventoryReport.call(current_user, start_date, end_date)
        return json_success(data: res.data) if res.success?

        json_failure(msg: res.message)
      end

      def customer_report
        res = Sales::CustomerSalesReport.call(current_user)
        return json_success(data: res.data) if res.success?

        json_failure(msg: res.message)
      end

      private

      def details_params
        params.permit(:start_date, :end_date)
      end

      def start_date
        DateTime.parse(details_params[:start_date]).beginning_of_day
      end

      def end_date
        DateTime.parse(details_params[:end_date]).end_of_day
      end
    end
  end
end
