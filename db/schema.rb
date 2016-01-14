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

ActiveRecord::Schema.define(version: 20160113174936) do

  create_table "car_templates", force: :cascade do |t|
    t.string   "brand",          limit: 255
    t.string   "model",          limit: 255
    t.string   "general_chassi", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "competitor_cars", force: :cascade do |t|
    t.string   "competitor_name",  limit: 255
    t.string   "auction",          limit: 255
    t.integer  "car_template_id",  limit: 4
    t.datetime "sold_date"
    t.text     "sold_car_notices", limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "competitor_cars", ["car_template_id"], name: "index_competitor_cars_on_car_template_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "order_cars", force: :cascade do |t|
    t.string   "chassi",          limit: 255
    t.string   "country",         limit: 255
    t.integer  "car_template_id", limit: 4
    t.integer  "customer_id",     limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "bought_by",       limit: 255
  end

  add_index "order_cars", ["car_template_id"], name: "index_order_cars_on_car_template_id", using: :btree
  add_index "order_cars", ["customer_id"], name: "index_order_cars_on_customer_id", using: :btree

  add_foreign_key "competitor_cars", "car_templates"
  add_foreign_key "order_cars", "car_templates"
  add_foreign_key "order_cars", "customers"
end
