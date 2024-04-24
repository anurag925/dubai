module Users
  # Service responsible for loggin in and logging out the user
  class LoginService < ApplicationService
    attr_reader :mobile_number, :otp

    def initialize(login_params)
      @mobile_number = login_params[:mobile_number]
      @otp = login_params[:otp]
    end

    def call
      return error(msg: 'user not found') unless user
      return generate_and_sent_otp if otp

      verify_otp_and_login_user
    end

    private

    def user
      @user ||= User.find_by(mobile_number: login_params[:mobile_number])
    end

    def generate_and_sent_otp
      otp = OtpService.new(user).generate(Otp::Action::LOGIN)
      return success(msg: 'otp generation successfull') if otp

      error(msg: 'unable to generate otp')
    end

    def verify_otp_and_login_user
      verified = OtpService.new(user).verify(Otp::Action::LOGIN, otp)
      return success(msg: 'otp verification success') if verified

      error(msg: 'otp verification failed')
    end
  end
end
