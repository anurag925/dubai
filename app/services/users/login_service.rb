# frozen_string_literal: true

module Users
  # Service responsible for login in and logging out the user
  class LoginService < ApplicationService
    attr_reader :mobile_number, :otp

    def initialize(login_params)
      @mobile_number = login_params[:mobile_number]
      @otp = login_params[:otp]
    end

    def call
      return error(msg: 'User is not registered') unless user
      return error(msg: 'User is blocked') if user.blocked?
      return generate_and_sent_otp unless otp

      verify_otp_and_login_user
    end

    private

    def user
      @user ||= User.find_by(mobile_number:)
    end

    def generate_and_sent_otp
      lol("generating login otp for the user_id #{user.id}")
      otp_generation = Otps::Sender.call(user, Otp::Action::LOGIN)
      return success(data: otp_sent_successfully) if otp_generation.success?

      error(msg: 'Unable to send otp')
    end

    def verify_otp_and_login_user
      lol("verifying login otp for the user_id #{user.id}")
      otp_verification = Otps::Utility.new(user).verify(Otp::Action::LOGIN, otp)
      return handle_success_otp_verification if otp_verification.success?

      error(msg: 'Otp verification failed')
    end

    def handle_success_otp_verification
      lol("logging in user_id #{user.id}")
      unless user.verified?
        lol("marking user_id #{user.id} verified")
        user.verified!
      end
      success(data: login_response)
    end

    def login_response
      {
        user:,
        token: user.token
      }
    end

    def otp_sent_successfully
      {
        msg: 'Otp sent successfully'
      }
    end
  end
end
