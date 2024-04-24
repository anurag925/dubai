# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_421_103_320) do
  create_table 'otps', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'value'
    t.string 'action'
    t.boolean 'verified', default: false
    t.integer 'retry_count', default: 0
    t.string 'receiver'
    t.integer 'receiver_type', limit: 1, default: 0
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_otps_on_user_id'
  end

  create_table 'users', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.string 'mobile_number', null: false
    t.integer 'status', limit: 1, default: 0
    t.integer 'type', limit: 1
    t.integer 'iters'
    t.string 'salt'
    t.string 'password_digest'
    t.bigint 'parent_id'
    t.index ['mobile_number'], name: 'index_users_on_mobile_number', unique: true
    t.index ['parent_id'], name: 'index_users_on_parent_id'
  end

  add_foreign_key 'users', 'users', column: 'parent_id'
end