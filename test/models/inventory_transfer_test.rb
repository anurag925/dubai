# frozen_string_literal: true

# == Schema Information
#
# Table name: inventory_transfers
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sender_id   :bigint
#  receiver_id :bigint
#  product_id  :bigint
#  transfer_id :string(255)      not null
#  quantity    :integer          default(0)
#  price       :decimal(10, 2)
#
# Indexes
#
#  index_inventory_transfers_on_product_id   (product_id)
#  index_inventory_transfers_on_receiver_id  (receiver_id)
#  index_inventory_transfers_on_sender_id    (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (receiver_id => users.id)
#  fk_rails_...  (sender_id => users.id)
#
require 'test_helper'

class InventoryTransferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
