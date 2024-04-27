# frozen_string_literal: true

# == Schema Information
#
# Table name: errors
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message    :string(255)
#  code       :string(255)
#  extra      :json
#  caller     :string(255)
#
# Indexes
#
#  index_errors_on_message  (message)
#
require 'test_helper'

class ErrorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
