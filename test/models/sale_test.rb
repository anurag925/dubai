# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  seller_id        :bigint
#  customer_id      :bigint
#  product_id       :bigint
#  product_name     :string(255)
#  quantity         :integer
#  price            :decimal(10, 2)
#  date_of_purchase :datetime
#
# Indexes
#
#  index_sales_on_customer_id               (customer_id)
#  index_sales_on_date_of_purchase          (date_of_purchase)
#  index_sales_on_product_id                (product_id)
#  index_sales_on_seller_id                 (seller_id)
#  index_sales_on_seller_id_and_product_id  (seller_id,product_id)
#
# Foreign Keys
#
#  fk_rails_...  (seller_id => users.id)
#
require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
