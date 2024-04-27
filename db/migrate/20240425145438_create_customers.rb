# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.timestamps

      t.string :name
      t.string :mobile_number, null: false, index: { unique: true }
    end
  end
end
