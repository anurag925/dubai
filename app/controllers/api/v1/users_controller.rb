# frozen_string_literal: true

module Api
  module V1
    # apis for users
    class UsersController < ApplicationController
      def index
        users = User.where
        return json_success(data: users.to_a) if invalidate_page_no

        json_success(data: users.limit(per_page).offset(page_no * per_page))
      end

      def register
        response = Users::RegistrationService.call(register_params)
        return json_success(msg: response.msg, data: response.data) if response.success?

        json_failure(msg: response.msg, data: response.data)
      end

      def login
        response = Users::LoginService.call(login_params)
        return json_success(msg: response.msg, data: response.data) if response.success?

        json_unauthorized(msg: response.msg, data: response.data)
      end

      private

      def register_params
        params.require(:user).permit(:mobile_number, :otp, :dob, :type, :parent_id)
      end

      def login_params
        params.require(:user).permit(:mobile_number, :otp)
      end

      def user
        @user ||= User.find_by(mobile_number: login_params[:mobile_number])
      end
    end
  end
end
