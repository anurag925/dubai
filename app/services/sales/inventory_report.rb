# frozen_string_literal: true

module Sales
  # class responsible for generating inventory report for a user
  # within a given time frame
  class InventoryReport < ApplicationService
    attr_reader :user, :report, :start_date, :end_date

    def initialize(user, start_date = nil, end_date = nil)
      @user = user
      @start_date = start_date || Utils::Timing.inception
      @end_date = end_date || DateTime.current
      @report = []
    end

    def call
      generate_report_for_each_inventory_item
      lol("the report for user_id #{user.id}, start #{start_date}, end #{end_date}, report #{report}")
      success(data: report)
    rescue StandardError => e
      sos('unable to generate inventory report',
          extra: { error: e.message, user_id: user.id, start_date:, end_date: })
      error(msg: 'unable to generate inventory report')
    end

    private

    def generate_report_for_each_inventory_item
      inventories.each do |inventory|
        report << generate_report_for_inventory(inventory)
      end
    end

    def inventories
      @inventories ||= user.inventories.includes(:product)
    end

    def generate_report_for_inventory(inventory)
      {
        name: inventory.product.name,
        category: inventory.product.category,
        balance: inventory.quantity,
        sales_quantity: inventory.sales.where(date_of_purchase: start_date...end_date).sum(:quantity),
        sales_amount: inventory.sales.where(date_of_purchase: start_date...end_date).sum('quantity * price')
      }
    end

    log_duration :call
  end
end
