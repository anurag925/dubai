# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.timestamps

      t.string :product_id, null: false
      t.string :name, null: false
      t.string :category
      t.decimal :price, precision: 10, scale: 2, default: 0.0
    end
  end
end
