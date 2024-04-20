# frozen_string_literal: true

# Migration for adding a user model
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :name
      t.string :mobile_number, null: false, index: { unique: true }
      t.integer :state
      t.integer :type
      t.integer :iters
      t.string :salt
      t.string :password_digest
    end
  end
end
