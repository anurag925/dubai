# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string(255)
#  mobile_number   :string(255)      not null
#  status          :integer          default("created")
#  type            :integer
#  iters           :integer
#  salt            :string(255)
#  password_digest :string(255)
#  parent_id       :bigint
#  registration_no :string(255)
#
# Indexes
#
#  index_users_on_mobile_number    (mobile_number) UNIQUE
#  index_users_on_parent_id        (parent_id)
#  index_users_on_registration_no  (registration_no)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => users.id)
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
