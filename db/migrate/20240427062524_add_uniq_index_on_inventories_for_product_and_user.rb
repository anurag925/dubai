# frozen_string_literal: true

class AddUniqIndexOnInventoriesForProductAndUser < ActiveRecord::Migration[7.1]
  def change
    add_index :inventories, %i[user_id product_id], unique: true
  end
end
