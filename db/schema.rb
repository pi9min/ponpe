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

ActiveRecord::Schema.define(version: 20160324040805) do

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "provider",     limit: 255
    t.string   "uid",          limit: 255
    t.string   "access_token", limit: 255
    t.string   "name",         limit: 255
    t.string   "email",        limit: 255
    t.string   "icon_url",     limit: 255
    t.integer  "permission",   limit: 1,   default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

  create_table "videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "url",           limit: 255
    t.string   "thumbnail_url", limit: 255
    t.string   "short_url",     limit: 4,                                     null: false, collation: "latin1_bin"
    t.string   "file_hash",     limit: 40,                                                 collation: "latin1_bin"
    t.string   "title",         limit: 255,                                   null: false, collation: "utf8mb4_unicode_ci"
    t.string   "description",   limit: 255,                                                collation: "utf8mb4_unicode_ci"
    t.integer  "category",      limit: 4,     default: 99,                    null: false
    t.integer  "state",         limit: 4,     default: 0,                     null: false
    t.string   "chapter",       limit: 255
    t.integer  "duration",      limit: 4,     default: 0,                     null: false
    t.datetime "recorded_at",                 default: '1970-01-01 00:00:00', null: false
    t.text     "raw_info",      limit: 65535
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  add_index "videos", ["short_url"], name: "index_videos_on_short_url", unique: true, using: :btree

end
