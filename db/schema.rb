# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140806073859) do

  create_table "accounting_entries", force: true do |t|
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.integer  "entry_id"
    t.integer  "side_id"
    t.integer  "item_id"
    t.integer  "amount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "accounting_entries", ["entry_id"], name: "index_accounting_entries_on_entry_id"
  add_index "accounting_entries", ["item_id"], name: "index_accounting_entries_on_item_id"
  add_index "accounting_entries", ["side_id"], name: "index_accounting_entries_on_side_id"
  add_index "accounting_entries", ["transaction_id"], name: "index_accounting_entries_on_transaction_id"
  add_index "accounting_entries", ["user_id"], name: "index_accounting_entries_on_user_id"

  create_table "accounting_items", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "type_id"
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "selectable",  default: false, null: false
  end

  add_index "accounting_items", ["type_id"], name: "index_accounting_items_on_type_id"
  add_index "accounting_items", ["user_id"], name: "index_accounting_items_on_user_id"

  create_table "accounting_sides", id: false, force: true do |t|
    t.integer  "id"
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounting_transactions", force: true do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "accounting_transactions", ["user_id"], name: "index_accounting_transactions_on_user_id"

  create_table "accounting_types", force: true do |t|
    t.string   "name"
    t.integer  "side_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounting_types", ["side_id"], name: "index_accounting_types_on_side_id"

  create_table "temp", id: false, force: true do |t|
    t.integer "id"
    t.string  "name", limit: nil
  end

  create_table "transactions", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image_url"
    t.string   "email"
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
