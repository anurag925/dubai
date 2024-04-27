# frozen_string_literal: true

# == Schema Information
#
# Table name: contents
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  url         :string(255)
#  type        :integer          default(0)
#  uploader_id :bigint
#
# Indexes
#
#  index_contents_on_uploader_id  (uploader_id)
#
# Foreign Keys
#
#  fk_rails_...  (uploader_id => users.id)
#
require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
