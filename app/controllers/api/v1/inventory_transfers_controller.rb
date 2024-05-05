# frozen_string_literal: true

module Api
  module V1
    # InventoryTransferController
    class InventoryTransfersController < ApplicationController
      before_action :authorize_user!

      def transfer; end

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
    end
  end
end
