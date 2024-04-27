# frozen_string_literal: true

module Sales
  # CustomerSalesReport responsible for generating customer report for a distributor
  # its response is used to show response on the customer sales report page
  class CustomerSalesReport < ApplicationService
    attr_reader :distributor, :report, :start_date, :end_date

    # @param [User] distributor
    def initialize(distributor)
      @distributor = distributor
    end

    def call
      success(data: generate_report)
    end

    private

    def sales
      @sales ||= distributor.sales
    end

    def generate_report
      counts = sales.select('count(*) as sales_count', 'count(distinct(customer_id)) as customer_count').first
      {
        sales_count: counts[:sales_count],
        customer_count: counts[:customer_count],
        flagged_people_count: 0
      }
    end
  end
end
