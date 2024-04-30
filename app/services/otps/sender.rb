# frozen_string_literal: true

module Otps
  # Sender is responsible for generating and sending otp to the user
  class Sender < ApplicationService
    attr_reader :user, :action

    # @param [User] user
    # @param [String] action
    def initialize(user, action)
      @user = user
      @action = action
    end

    def call
      if otp_generation.success?
        lol("otp generated for action #{action} user_id: #{user.id}")
        return send_otp
      end

      lol("otp generation failed for action #{action} user_id: #{user.id}")
      error(msg: 'Otp sending failed')
    end

    private

    def otp_generation
      @otp_generation ||= Otps::Utility.new(user).generate(action)
    end

    # has not been implemented yet
    def send_otp
      # logic to send otp
      lol("otp sent to user_id: #{user.id} for action: #{action}")
      success(msg: 'Otp sent successfully', data: otp_generation.data)
    end
  end
end
