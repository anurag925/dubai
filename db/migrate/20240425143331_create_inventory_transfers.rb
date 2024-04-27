# frozen_string_literal: true

class CreateInventoryTransfers < ActiveRecord::Migration[7.1]
  def change
    create_table :inventory_transfers do |t|
      t.timestamps

      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.references :product

      t.string :transfer_id, null: false
      t.integer :quantity, default: 0
      t.decimal :price, precision: 10, scale: 2
    end
  end
end
