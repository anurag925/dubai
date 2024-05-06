# frozen_string_literal: true

module Api
  module V1
    # InventoryTransferController
    class InventoryTransfersController < ApplicationController
      before_action :authorize_user!

      def transfer
        res = bulk_transfer
        return json_success(msg: res.msg, data: res.data) if res.success?

        json_failure(msg: res.msg)
      end

      def transfer_details
        res = {
          product_details: Inventories::AvailableProducts.call(current_user).data,
          area_development_officers: User.area_development_officer.where(parent_id: 1).pluck(:id, :name)
                                         .map { |id, name| { id:, name: } }
        }
        json_success(data: res)
      end

      private

      def transfer_params
        params.require(:transfer).permit(:from, :product_id, :quantity, :target, to: [])
      end

      def bulk_transfer
        Inventories::BulkTransfer.new(
          current_user,
          transfer_params[:to],
          quantity: transfer_params[:quantity],
          product_id: transfer_params[:product_id],
          target: transfer_params[:target]
        ).call
      end
    end
  end
end
