# frozen_string_literal: true

# == Schema Information
#
# Table name: otps
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  value         :string(255)
#  action        :string(255)
#  verified      :boolean          default(FALSE)
#  retry_count   :integer          default(0)
#  receiver      :string(255)
#  receiver_type :integer          default("mobile")
#  user_id       :bigint
#
# Indexes
#
#  index_otps_on_user_id  (user_id)
#
class Otp < ApplicationRecord
  enum receiver_type: { mobile: 0, email: 1 }

  module Action
    REGISTRATION = 'registration'
    LOGIN = 'login'
  end

  # def generate(user, action)
  #   create({
  #            user_id: user.id,
  #            receiver: user.mobile_number,
  #            receiver_type: 'mobile_number',
  #            value: otp_value,
  #            action:
  #          }).value
  # end

  # def
  #   return 1111 if Rails.env.development?

  #   (SecureRandom.random_number(9e5) + 1e5).to_i
  # end

  # def self.verify!(otp_value, options)
  #   last_otp = where(user_id: options[:user_id], receiver: options[:receiver], otp_type: options[:otp_type],
  #                    verified: false).last
  #   return false unless last_otp

  #   # value = Rails.env.production? ? otp.value : '111111'
  #   return last_otp.update(verified: true) if otp_value.to_s == last_otp.value.to_s

  #   last_otp.update(retry_count: last_otp.retry_count + 1)

  #   false # can do better here
  # end
end
