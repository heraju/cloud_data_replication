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

ActiveRecord::Schema.define(version: 20170921151952) do

  create_table "downloads", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_upload_id"
    t.string   "description"
    t.boolean  "apporve"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fragments", force: true do |t|
    t.integer  "node_id"
    t.integer  "user_upload_id"
    t.string   "fragment"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.integer  "cost"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.integer  "node_count"
    t.integer  "fragment_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_uploads", force: true do |t|
    t.integer  "user_id"
    t.string   "file"
    t.string   "key"
    t.integer  "rc_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "node_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.boolean  "active"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end