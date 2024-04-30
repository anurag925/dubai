# frozen_string_literal: true

module Users
  # service responsible for creating user
  class CreateHelper < ApplicationService
    attr_reader :user_params

    # @param [Hash] user_params
    # @option user_params [String] :mobile_number
    # @option user_params [String] :dob
    # @option user_params [Integer] :parent_id
    # @option user_params [String] :type
    def initialize(user_params)
      @user_params = user_params
    end

    def call
      user.save!
      success(data: user)
    rescue StandardError => e
      alert!('unable to create user', extra: { msg: user.errors.full_messages.to_sentence, error: e, user_params: })
      error(msg: user.errors.full_messages.to_sentence)
    end

    private

    def user
      @user ||= User.new(user_create_param)
    end

    def registration_no
      @registration_no ||= "REG_#{SecureRandom.hex(6)}"
    end

    def user_create_param
      user_params.merge(registration_no:)
    end
  end
end
