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

ActiveRecord::Schema.define(version: 20160514165617) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "infos", force: :cascade do |t|
    t.string   "temp"
    t.string   "hum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payloads", force: :cascade do |t|
    t.integer  "time"
    t.float    "temperature"
    t.float    "humidity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sensors", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sensors", ["category_id"], name: "index_sensors_on_category_id"

  create_table "values", force: :cascade do |t|
    t.integer  "type"
    t.float    "val_float"
    t.integer  "val_int"
    t.text     "val_str"
    t.boolean  "val_bool"
    t.integer  "sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "values", ["sensor_id"], name: "index_values_on_sensor_id"

end
