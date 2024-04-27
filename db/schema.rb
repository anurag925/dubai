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

ActiveRecord::Schema[7.1].define(version: 2024_04_27_062524) do
  create_table "contents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "url"
    t.integer "type", limit: 1, default: 0
    t.bigint "uploader_id"
    t.index ["uploader_id"], name: "index_contents_on_uploader_id"
  end

  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "mobile_number", null: false
    t.index ["mobile_number"], name: "index_customers_on_mobile_number", unique: true
  end

  create_table "errors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message"
    t.string "code"
    t.json "extra"
    t.string "caller"
    t.index ["message"], name: "index_errors_on_message"
  end

  create_table "inventories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "product_id"
    t.integer "quantity", default: 0
    t.index ["product_id"], name: "index_inventories_on_product_id"
    t.index ["user_id", "product_id"], name: "index_inventories_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "inventory_transfers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.bigint "product_id"
    t.string "transfer_id", null: false
    t.integer "quantity", default: 0
    t.decimal "price", precision: 10, scale: 2
    t.index ["product_id"], name: "index_inventory_transfers_on_product_id"
    t.index ["receiver_id"], name: "index_inventory_transfers_on_receiver_id"
    t.index ["sender_id"], name: "index_inventory_transfers_on_sender_id"
  end

  create_table "otps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
    t.string "action"
    t.boolean "verified", default: false
    t.integer "retry_count", default: 0
    t.string "receiver"
    t.integer "receiver_type", limit: 1, default: 0
    t.bigint "user_id"
    t.index ["user_id"], name: "index_otps_on_user_id"
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product_id", null: false
    t.string "name", null: false
    t.string "category"
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
  end

  create_table "sales", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "seller_id"
    t.bigint "customer_id"
    t.bigint "product_id"
    t.string "product_name"
    t.integer "quantity"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "date_of_purchase"
    t.index ["customer_id"], name: "index_sales_on_customer_id"
    t.index ["date_of_purchase"], name: "index_sales_on_date_of_purchase"
    t.index ["product_id"], name: "index_sales_on_product_id"
    t.index ["seller_id", "product_id"], name: "index_sales_on_seller_id_and_product_id"
    t.index ["seller_id"], name: "index_sales_on_seller_id"
  end

  create_table "targets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "product_id"
    t.integer "value"
    t.index ["product_id"], name: "index_targets_on_product_id"
    t.index ["user_id"], name: "index_targets_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "mobile_number", null: false
    t.integer "status", limit: 1, default: 0
    t.integer "type", limit: 1
    t.integer "iters"
    t.string "salt"
    t.string "password_digest"
    t.bigint "parent_id"
    t.string "registration_no"
    t.index ["mobile_number"], name: "index_users_on_mobile_number", unique: true
    t.index ["parent_id"], name: "index_users_on_parent_id"
    t.index ["registration_no"], name: "index_users_on_registration_no"
  end

  add_foreign_key "contents", "users", column: "uploader_id"
  add_foreign_key "inventory_transfers", "users", column: "receiver_id"
  add_foreign_key "inventory_transfers", "users", column: "sender_id"
  add_foreign_key "sales", "users", column: "seller_id"
  add_foreign_key "users", "users", column: "parent_id"
end
