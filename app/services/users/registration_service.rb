# frozen_string_literal: true

module Users
  # Service responsible for registration of user
  class RegistrationService < ApplicationService
    attr_reader :user_params, :otp

    # @param [Hash] register_params
    # @option register_params [String] :mobile_number
    # @option register_params [String] :otp
    # @option register_params [String] :dob
    # @option register_params [Integer] :parent_id
    # @option register_params [String] :type
    # @return [ApplicationService]
    def initialize(register_params)
      @user_params = register_params.except(:otp)
      @otp = register_params[:otp]
    end

    def call
      return handle_users_presence if user

      handle_users_absence
    end

    private

    def user
      @user ||= User.find_by(mobile_number: user_params[:mobile_number])
    end

    def handle_users_presence
      lol("registration triggered for user already registered for user_id #{user.id}")
      return success_msg('User already registered') if user_params[:parent_id].present?
      return verify_user_using_otp unless user.verified?

      error(msg: 'Please login')
    end

    def handle_users_absence
      create_user_response = Users::CreateHelper.call(user_params)
      if create_user_response.success?
        @user = create_user_response.data
        lol("user creation success for user_id #{user.id}")
        return verify_user_using_otp
      end

      error(msg: create_user_response.msg)
    end

    def verify_user_using_otp
      return verify_user_otp if otp.present?

      send_otp_to_user
    end

    def verify_user_otp
      lol("verifying otp for user_id #{user.id} for registration otp #{otp}")
      otp_verification = Otps::Utility.new(user).verify(Otp::Action::REGISTRATION, otp)
      return handle_success_otp_verification if otp_verification.success?

      error(msg: 'Otp verification failed')
    end

    def handle_success_otp_verification
      lol("verifying during registration user_id #{user.id}")
      unless user.verified?
        lol("marking user_id #{user.id} verified")
        user.verified!
      end
      success_msg('Otp verification success please login')
    end

    def send_otp_to_user
      sending_otp = Otps::Sender.call(user, Otp::Action::REGISTRATION)
      return success_msg('Otp sent successfully') if sending_otp.success?

      error(msg: 'Otp generation failed')
    end
  end
end
