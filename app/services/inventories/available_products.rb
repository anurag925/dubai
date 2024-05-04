# frozen_string_literal: true

module Inventories
  # Responsible for providing all the available products in the inventory
  class AvailableProducts < ApplicationService
    attr_reader :user, :details

    def initialize(user)
      @user = user
      @details = []
    end

    def call
      available_inventories.each do |inventory|
        details << generate_details(inventory)
      end
      success(data: details)
    end

    private

    def available_inventories
      @available_inventories ||= user.inventories.includes(:product).where('quantity > 0')
    end

    def generate_details(inventory)
      {
        name: inventory.product.name,
        category: inventory.product.category,
        quantity: inventory.quantity,
        price: inventory.product.price.to_f,
        inventory_id: inventory.id,
        product_id: inventory.product.id
      }
    end
  end
end
