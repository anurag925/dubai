# frozen_string_literal: true

# == Schema Information
#
# Table name: inventories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  product_id :bigint
#  quantity   :integer          default(0)
#
# Indexes
#
#  index_inventories_on_product_id              (product_id)
#  index_inventories_on_user_id                 (user_id)
#  index_inventories_on_user_id_and_product_id  (user_id,product_id) UNIQUE
#
class Inventory < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def sales
    Sale.where(seller_id: user_id, product_id:)
  end
end
