# frozen_string_literal: true

# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  product_id :bigint
#  value      :integer
#
# Indexes
#
#  index_targets_on_product_id  (product_id)
#  index_targets_on_user_id     (user_id)
#
class Target < ApplicationRecord
  belongs_to :user
end
