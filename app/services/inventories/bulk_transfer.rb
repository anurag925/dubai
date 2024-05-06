# frozen_string_literal: true

module Inventories
  # BulkTransfer transfers same product same quantity to multiple users in bulk
  class BulkTransfer < ApplicationService
    attr_reader :sender, :receiver_ids, :quantity, :product_id, :transfer_id, :target, :transfer_options

    # @param sender [User]
    # @param receivers [User]
    # @param transfer_options [Hash]
    # @option transfer_options [Integer] :quantity
    # @option transfer_options [Integer] :product_id
    def initialize(sender, receiver_ids, transfer_options)
      @sender = sender
      @receiver_ids = receiver_ids
      @quantity = transfer_options[:quantity]
      @product_id = transfer_options[:product_id]
      @target = transfer_options[:target]
      @transfer_id = transfer_options[:transfer_id] || Utils::Random.id
      @outbound_transfers = []
    end

    def call
      if total_quantity > sender_inventory.quantity
        return error(msg: 'total transferring quantity is less than available quantity')
      end

      perform_transfer
      success(msg: 'transfer done successfully')
    rescue StandardError => e
      error(msg: e.message)
    end

    private

    def sender_inventory
      @sender_inventory ||= sender.inventories.find_by(product_id:)
    end

    def product
      @product ||= Product.find(product_id)
    end

    def price
      product.price
    end

    def perform_transfer_for_one_receiver
      Transfer.new(sender, User.find(receiver_ids.first), transfer_options)
    end

    def total_quantity
      quantity * receiver_ids.count
    end

    def perform_transfer
      lol("transferring inventory #{transfer_id} from #{sender.id} to #{receiver_ids} for #{transfer_options}")
      Inventory.transaction { run_transfer_logic }
    end

    def run_transfer_logic
      total_transferred_quantity = 0
      receiver_ids.each do |receiver_id|
        lol("calculating transfer for receiver_id: #{receiver_id}")
        create_transfer_for_receiver(receiver_id)
        Target.create(user_id: receiver_id, product_id:, value: target) if target
        total_transferred_quantity += quantity
      end
      lol("calculating transfer for sender total_transferred_quantity is #{total_transferred_quantity}")
      sender_inventory.quantity -= total_transferred_quantity
      sender_inventory.save!
    end

    def create_transfer_for_receiver(receiver_id)
      InventoryTransfer.create!(sender_id: sender.id, receiver_id:, product_id:, transfer_id:, quantity:, price:)
      receiver_inventory = User.find(receiver_id).inventories.find_or_initialize_by(product_id:)
      receiver_inventory.quantity += quantity
      receiver_inventory.save!
    end
  end
end
