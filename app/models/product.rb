# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :string(255)      not null
#  name       :string(255)      not null
#  category   :string(255)
#  price      :decimal(10, 2)   default(0.0)
#
class Product < ApplicationRecord
  has_many :sales, dependent: :restrict_with_exception
end
