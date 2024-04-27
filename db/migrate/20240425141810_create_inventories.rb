# frozen_string_literal: true

class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.timestamps

      t.references :user
      t.references :product
      t.integer :quantity, default: 0
    end
  end
end
