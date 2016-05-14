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

ActiveRecord::Schema.define(version: 20160514195041) do

  create_table "articles", primary_key: "twitter_id", force: true do |t|
    t.string   "site"
    t.text     "url"
    t.string   "title"
    t.text     "photo_url"
    t.text     "description"
    t.date     "published_at"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_hours", force: true do |t|
    t.integer  "location_id", null: false
    t.integer  "day_of_week", null: false
    t.decimal  "open",        null: false
    t.decimal  "close",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.boolean  "current",      default: false, null: false
    t.string   "neighborhood",                 null: false
    t.string   "street",                       null: false
    t.string   "city",                         null: false
    t.string   "state",                        null: false
    t.integer  "zipcode",                      null: false
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.date     "live_on"
  end

end
