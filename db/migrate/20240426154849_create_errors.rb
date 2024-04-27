# frozen_string_literal: true

class CreateErrors < ActiveRecord::Migration[7.1]
  def change
    create_table :errors do |t|
      t.timestamps
      t.string :message, index: true
      t.string :code
      t.json :extra
      t.string :caller
    end
  end
end
