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

ActiveRecord::Schema.define(version: 20141015133911) do

  create_table "node_categories", force: true do |t|
    t.string   "name",       limit: 15, null: false
    t.string   "slug",       limit: 31, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.string   "name",       limit: 15,                                 null: false
    t.string   "slug",       limit: 31,                                 null: false
    t.string   "decription"
    t.boolean  "need_login",                            default: false, null: false
    t.integer  "min_group",  limit: 3,  unsigned: true, default: 0,     null: false
    t.integer  "min_role",   limit: 3,  unsigned: true, default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "nickname",               limit: 8,                              null: false
    t.integer  "group_id",               limit: 3, unsigned: true, default: 1,  null: false
    t.integer  "role_id",                limit: 3, unsigned: true, default: 1,  null: false
    t.integer  "topics_count",                                     default: 0,  null: false
    t.integer  "replies_count",                                    default: 0,  null: false
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                            default: "", null: false
    t.string   "encrypted_password",                               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    unsigned: true, default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                  unsigned: true, default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
