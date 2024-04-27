# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string(255)
#  mobile_number :string(255)      not null
#
# Indexes
#
#  index_customers_on_mobile_number  (mobile_number) UNIQUE
#
class Customer < ApplicationRecord
end
