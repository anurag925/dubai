# frozen_string_literal: true

class CreateContents < ActiveRecord::Migration[7.1]
  def change
    create_table :contents do |t|
      t.timestamps

      t.string :name
      t.string :url
      t.integer :type, limit: 1, default: 0
      t.references :uploader, foreign_key: { to_table: :users }
    end
  end
end
