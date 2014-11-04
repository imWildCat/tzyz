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

ActiveRecord::Schema.define(version: 20141102030020) do

  create_table "admin_action_reasons", force: true do |t|
    t.string "description", limit: 63
  end

  create_table "messages", force: true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.boolean  "is_read",                 default: false
    t.string   "content",     limit: 511,                 null: false
    t.datetime "created_at",                              null: false
    t.datetime "deleted_at"
  end

  add_index "messages", ["is_read"], name: "index_messages_on_is_read", using: :btree
  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "node_categories", force: true do |t|
    t.string   "name",       limit: 15, null: false
    t.string   "slug",       limit: 31, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.integer  "node_category_id",                            null: false
    t.string   "name",             limit: 15,                 null: false
    t.string   "slug",             limit: 31,                 null: false
    t.string   "description"
    t.boolean  "need_login",                  default: false, null: false
    t.integer  "min_group",        limit: 3,  default: 0,     null: false
    t.integer  "min_role",         limit: 3,  default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["name"], name: "index_nodes_on_name", unique: true, using: :btree
  add_index "nodes", ["slug"], name: "index_nodes_on_slug", unique: true, using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "receiver_id",                                null: false
    t.integer  "n_type",           limit: 3,                 null: false
    t.boolean  "is_read",                    default: false, null: false
    t.integer  "reason_id"
    t.integer  "related_user_id"
    t.integer  "related_topic_id"
    t.integer  "related_reply_id"
    t.datetime "created_at",                                 null: false
    t.datetime "deleted_at"
  end

  add_index "notifications", ["is_read"], name: "index_notifications_on_is_read", using: :btree
  add_index "notifications", ["receiver_id"], name: "index_notifications_on_receiver_id", using: :btree

  create_table "replies", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id",   null: false
    t.integer  "author_id",  null: false
    t.text     "content",    null: false
    t.datetime "deleted_at"
  end

  add_index "replies", ["author_id"], name: "index_replies_on_author_id", using: :btree
  add_index "replies", ["deleted_at"], name: "index_replies_on_deleted_at", using: :btree

  create_table "statistics", id: false, force: true do |t|
    t.integer "type",       null: false
    t.integer "related_id"
    t.integer "value"
  end

  add_index "statistics", ["type", "related_id"], name: "index_statistics_on_type_and_related_id", unique: true, using: :btree
  add_index "statistics", ["type"], name: "index_statistics_on_type", using: :btree
  add_index "statistics", ["value"], name: "index_statistics_on_value", using: :btree

  create_table "topics", force: true do |t|
    t.datetime "created_at",                              null: false
    t.integer  "node_id",                                 null: false
    t.integer  "author_id",                               null: false
    t.integer  "refresher_id",                            null: false
    t.string   "title",           limit: 127,             null: false
    t.integer  "clicks_count",                default: 0, null: false
    t.integer  "replies_count",               default: 0, null: false
    t.text     "content",                                 null: false
    t.datetime "last_replied_at"
  end

  add_index "topics", ["author_id"], name: "index_topics_on_author_id", using: :btree
  add_index "topics", ["last_replied_at"], name: "index_topics_on_last_replied_at", using: :btree

  create_table "user_avatars", primary_key: "owner_id", force: true do |t|
    t.boolean "is_enabled",            default: true, null: false
    t.string  "filename",   limit: 31
    t.string  "ttk_url"
  end

  create_table "user_profiles", primary_key: "owner_id", force: true do |t|
    t.string "name",         limit: 15
    t.string "city",         limit: 31
    t.string "website"
    t.string "weibo",        limit: 63
    t.string "introduction"
  end

  create_table "users", force: true do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "nickname",               limit: 8,              null: false
    t.integer  "group_id",               limit: 3, default: 1,  null: false
    t.integer  "role_id",                limit: 3, default: 1,  null: false
    t.integer  "topics_count",                     default: 0,  null: false
    t.integer  "replies_count",                    default: 0,  null: false
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                  default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
