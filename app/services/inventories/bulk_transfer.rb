# frozen_string_literal: true

module Inventories
  # BulkTransfer transfers same product same quantity to multiple users in bulk
  class BulkTransfer < ApplicationService
    attr_reader :sender, :receiver_ids, :quantity, :product_id, :transfer_id

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
      @transfer_id = transfer_options[:transfer_id] || Utils::Random.id
      @outbound_transfers = []
    end

    def call
      return perform_transfer_for_one_receiver if receiver_ids.count.eql?(1)
      if total_quantity > sender_inventory.quantity
        return error(msg: 'total transferring quantity is less than available quantity')
      end

      perform_transfer
      success(msg: 'transfer done successfully')
    end

    private

    def sender_inventory
      @sender_inventory ||= sender.inventories.find_by(product_id:)
    end

    def perform_transfer_for_one_receiver
      Transfer.new(sender, User.find(receiver_ids.first), transfer_options)
    end

    def total_quantity
      quantity * receiver_ids.count
    end

    def perform_transfer
      lol("transferring inventory id #{transfer_id} from #{sender.id} to #{receiver_ids} for #{product.id} quantity #{quantity}")
      receiver_ids.each do |receiver_id|
        lol("calculating transfer for receiver_id: #{receiver_id}")
      end
    end
  end
end
