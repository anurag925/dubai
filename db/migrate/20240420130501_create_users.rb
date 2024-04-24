# frozen_string_literal: true

# Migration for adding a user model
class CreateUsers < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :users do |t|
      t.timestamps
      t.string :name
      t.string :mobile_number, null: false, index: { unique: true }
      t.integer :status, limit: 1, default: 0
      t.integer :type, limit: 1
      t.integer :iters
      t.string :salt
      t.string :password_digest
      t.references :parent, foreign_key: { to_table: :users }
    end
  end
end
