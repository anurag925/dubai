# frozen_string_literal: true

# migration for creating an otp table
class CreateOtps < ActiveRecord::Migration[7.1]
  def change
    create_table :otps do |t|
      t.timestamps

      t.string :value
      t.string :action
      t.boolean :verified, null: false, default: false
      t.integer :retry_count, default: 0
      t.string :receiver
      t.integer :receiver_type, limit: 1, default: 0
      t.references :user
    end
  end
end
