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

ActiveRecord::Schema.define(version: 20141016011204) do

  create_table "messages", force: true do |t|
    t.integer  "receiver_id",             unsigned: true
    t.integer  "sender_id",               unsigned: true
    t.string   "content",     limit: 511,                 null: false
    t.datetime "created_at",                              null: false
    t.datetime "deleted_at"
  end

  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id", using: :btree

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

  add_index "nodes", ["name"], name: "index_nodes_on_name", unique: true, using: :btree
  add_index "nodes", ["slug"], name: "index_nodes_on_slug", unique: true, using: :btree

  create_table "replies", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id",   null: false
    t.integer  "user_id",    null: false
    t.text     "content",    null: false
  end

  add_index "replies", ["topic_id", "user_id"], name: "index_replies_on_topic_id_and_user_id", using: :btree

  create_table "topics", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                                  null: false
    t.string   "title",            limit: 127,             null: false
    t.integer  "click_count",                  default: 0, null: false
    t.integer  "reply_count",                  default: 0, null: false
    t.text     "content",                                  null: false
    t.datetime "last_modified_at"
  end

  add_index "topics", ["user_id", "last_modified_at"], name: "index_topics_on_user_id_and_last_modified_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "nickname",               limit: 8,                              null: false
    t.integer  "group_id",               limit: 3, unsigned: true, default: 1,  null: false
    t.integer  "role_id",                limit: 3, unsigned: true, default: 1,  null: false
    t.integer  "topics_count",                     unsigned: true, default: 0,  null: false
    t.integer  "replies_count",                    unsigned: true, default: 0,  null: false
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
