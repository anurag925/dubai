# frozen_string_literal: true

class AddRegistrationNoInUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :registration_no
      t.index :registration_no
    end
  end
end
