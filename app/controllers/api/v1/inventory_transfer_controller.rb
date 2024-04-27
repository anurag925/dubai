# frozen_string_literal: true

module Api
  module V1
    class InventoryTransferController < ApplicationController
      def transfer; end

      private

      def transfer_params
        params.require(:transfer).permit(:from, :product_id, :quantity, :target, to: [])
      end
    end
  end
end
