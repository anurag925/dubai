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
require 'test_helper'

class OtpTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
