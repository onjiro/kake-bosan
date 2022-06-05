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

ActiveRecord::Schema[7.0].define(version: 2022_06_05_005949) do
  create_table "accounting_entries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "transaction_id", null: false
    t.integer "side_id", null: false
    t.integer "item_id", null: false
    t.integer "amount", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["item_id"], name: "index_accounting_entries_on_item_id"
    t.index ["side_id"], name: "index_accounting_entries_on_side_id"
    t.index ["transaction_id"], name: "index_accounting_entries_on_transaction_id"
    t.index ["user_id", "item_id", "side_id"], name: "index_accounting_entries_on_user_id_and_item_id_and_side_id"
    t.index ["user_id"], name: "index_accounting_entries_on_user_id"
  end

  create_table "accounting_items", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.integer "type_id", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "selectable", default: true, null: false
    t.index ["type_id"], name: "index_accounting_items_on_type_id"
    t.index ["user_id"], name: "index_accounting_items_on_user_id"
  end

  create_table "accounting_sides", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "name", null: false
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "accounting_transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "date", precision: nil, null: false
    t.string "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["date"], name: "index_accounting_transactions_on_date"
    t.index ["user_id", "date"], name: "index_accounting_transactions_on_user_id_and_date"
  end

  create_table "accounting_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "side_id", null: false
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["side_id"], name: "index_accounting_types_on_side_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.integer "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "inventory_settings", primary_key: "user_id", force: :cascade do |t|
    t.integer "debit_item_id", null: false
    t.integer "credit_item_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "name"
    t.string "image_url"
    t.string "email"
    t.string "access_token"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
