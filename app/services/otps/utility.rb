# frozen_string_literal: true

module Otps
  # All otp related logic for generation and verification stays here
  class Utility < ApplicationService
    attr_reader :user

    # @param user [User]
    def initialize(user)
      @user = user
    end

    # method used for generating otp
    # @param action [String]
    # @returns [Response]
    def generate(action)
      otp = Otp.mobile.create!(action:, value:, user_id: user.id, receiver: user.mobile_number)
      success(data: otp)
    rescue StandardError
      error(msg: 'unable to generate otp', data: otp.errors.full_messages.to_sentence)
    end

    # method used for generating otp
    # @param action [String]
    # @param value [String]
    # @returns [Response]
    def verify(action, value)
      otp = Otp.where(action:, user_id: user.id, verified: false).last
      if otp && otp.value.eql?(value)
        otp.update!(verified: true)
        return success(msg: 'otp verification successful')
      end

      error(msg: 'otp verification failed')
    end

    private

    def value
      @value ||= if Rails.env.development?
                   1111
                 else
                   (SecureRandom.random_number(9e5) + 1e5).to_i
                 end
    end
  end
end
