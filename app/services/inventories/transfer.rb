# frozen_string_literal: true

module Inventories
  # Transfer is responsible for transferring inventory from one user to another
  # it takes care of one to one transfer
  class Transfer < ApplicationService
    attr_reader :sender, :receiver, :quantity, :product_id, :transfer_id, :transfer_options

    # @param sender [User]
    # @param receiver [User]
    # @param transfer_options [Hash]
    # @option transfer_options [Integer] :quantity
    # @option transfer_options [Integer] :product_id
    def initialize(sender, receiver, transfer_options)
      @sender = sender
      @receiver = receiver
      @quantity = transfer_options[:quantity]
      @product_id = transfer_options[:product_id]
      @transfer_id = transfer_options[:transfer_id] || Utils::Random.id
    end

    def call
      return error(msg: 'sender has less quantity than need') if sender_inventory.quantity < quantity

      lol("transferring inventory id #{transfer_id} from #{sender.id} to #{receiver.id} for #{transfer_options}")
      perform_transfer
      success(msg: 'transfer done successfully')
    end

    private

    def sender_inventory
      @sender_inventory ||= sender.inventories.find_by(product_id:)
    end

    def receiver_inventory
      @receiver_inventory ||= receiver.inventories.find_or_initialize_by(product_id:)
    end

    def product
      @product ||= Product.find(product_id)
    end

    # at the moment price is kept same as that of product
    # but price of the product at admin can be different as compared to the price
    # at which the item is being transferred
    # so for future provision this is kept here
    def price
      product.price
    end

    def perform_transfer
      Inventory.transaction do
        receiver_inventory.update!(quantity: receiver_inventory.quantity + quantity)
        sender_inventory.update!(quantity: sender_inventory.quantity - quantity)
        sender.outbound_transfers.create!(receiver:, product:, transfer_id:, quantity:, price:)
      end
    end
  end
end
