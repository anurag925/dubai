# frozen_string_literal: true

# adding dob in users table
class AddDobInUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :dob, :string
  end
end
