# frozen_string_literal: true

module Api
  module V1
    # apis for users
    class UsersController < ApplicationController
      def register
      end

      private

      def register_params
        params.require(:user).permit(:mobile_number, :otp)
      end
    end
  end
end
