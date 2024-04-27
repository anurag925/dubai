# frozen_string_literal: true

module Users
  # Service responsible for loggin in and logging out the user
  class RegistrationService < ApplicationService
    attr_reader :mobile_number, :otp, :name, :dob, :admin

    def initialize(register_params)
      @name = register_params[:name]
      @mobile_number = register_params[:mobile_number]
      @dob = register_params[:dob]
      @admin = register_params[:admin]
      @type = register_params[:type]
      @otp = login_params[:otp]
    end

    def call
      handle_users_presence if user

      handle_users_absence
    end

    private

    def user
      @user ||= User.find_by(mobile_number:)
    end

    def handle_users_presence
      success(msg: 'user already registered') if admin
      verify_user_using_otp unless user.verified?

      error(msg: 'please login')
    end

    def handle_users_absence
      @user = User.new(name:, mobile_number:, dob:, type:)
      return send_otp_to_user if user.save

      error(msg: 'user creation failed', errors: user.errors.full_messages.to_sentence)
    end

    def verify_user_using_otp
      return verify_user_otp if otp.present?

      send_otp_to_user
    end

    def verify_user_otp
      verified = OtpService.new(user).verify(Otp::Action::REGISTRATION, otp)
      return success(msg: 'otp verification success') if verified

      error(msg: 'otp verification failed')
    end

    def send_otp_to_user
      otp = OtpService.new(user).generate(Otp::Action::REGISTRATION)
      send_otp(otp.data) if otp.success

      error(msg: 'otp generation failed')
    end
  end
end
