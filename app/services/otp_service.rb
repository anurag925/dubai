# frozen_string_literal: true

# All otp related logic stays here
class OtpService < ApplicationService
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
    otp = Otp.where(action:, user_id: user.id, receiver: user.mobile_number, verified: false).last
    success(msg: 'otp verification successfull') if otp && otp.value.eql?(value)

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
