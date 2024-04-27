# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.timestamps

      t.references :seller, foreign_key: { to_table: :users }
      t.references :customer
      t.references :product
      t.string :product_name
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2
      t.datetime :date_of_purchase, index: true
    end

    add_index :sales, %i[seller_id product_id]
  end
end
