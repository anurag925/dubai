# frozen_string_literal: true

# All otp related logic stays here
class OtpService < ApplicationService
  attr_reader :user

  # @param user [User]
  def initialize(user)
    @user = user
  end

  # method used for generating otp
  # @param user [User]
  # @param action [String]
  # @returns [Response]
  def generate(action)
    created = Otp.mobile.create(action:, value:, user_id: user.id, receiver: user.mobile_number)
    success(data: created) if created

    error(msg: 'unable to generate otp')
  end

  def verify(value)
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
