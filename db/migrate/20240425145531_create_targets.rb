# frozen_string_literal: true

class CreateTargets < ActiveRecord::Migration[7.1]
  def change
    create_table :targets do |t|
      t.timestamps

      t.references :user
      t.references :product
      t.integer :value
    end
  end
end
