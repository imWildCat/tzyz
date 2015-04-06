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

ActiveRecord::Schema.define(version: 20141226154055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_action_reasons", force: :cascade do |t|
    t.string "description", limit: 63
  end

  create_table "appreciations", force: :cascade do |t|
    t.integer "user_id",                      null: false
    t.integer "appreciative_id",              null: false
    t.string  "appreciative_type", limit: 31, null: false
  end

  add_index "appreciations", ["appreciative_id", "appreciative_type"], name: "index_appreciations_on_appreciative_id_and_appreciative_type", using: :btree
  add_index "appreciations", ["user_id", "appreciative_id", "appreciative_type"], name: "unique_index", unique: true, using: :btree
  add_index "appreciations", ["user_id"], name: "index_appreciations_on_user_id", using: :btree

  create_table "authorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",     limit: 31
    t.string   "uid",          limit: 255
    t.string   "name",         limit: 63
    t.string   "image",        limit: 255
    t.string   "token",        limit: 255
    t.string   "secret",       limit: 255
    t.string   "profile_page", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "authorizations", ["provider", "user_id"], name: "index_authorizations_on_provider_and_user_id", using: :btree
  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id", using: :btree

  create_table "favorite_topics", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "topic_id",   null: false
    t.datetime "deleted_at"
  end

  add_index "favorite_topics", ["deleted_at"], name: "index_favorite_topics_on_deleted_at", using: :btree
  add_index "favorite_topics", ["topic_id"], name: "index_favorite_topics_on_topic_id", using: :btree
  add_index "favorite_topics", ["user_id", "topic_id"], name: "index_favorite_topics_on_user_id_and_topic_id", unique: true, using: :btree
  add_index "favorite_topics", ["user_id"], name: "index_favorite_topics_on_user_id", using: :btree

  create_table "fortune_alterations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "quantity",                          default: 0, null: false
    t.integer  "balance",                           default: 0, null: false
    t.integer  "reason",                                        null: false
    t.integer  "fortune_alterable_id"
    t.string   "fortune_alterable_type", limit: 31
    t.datetime "created_at",                                    null: false
  end

  add_index "fortune_alterations", ["user_id"], name: "index_fortune_alterations_on_user_id", using: :btree

  create_table "management_logs", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "manageable_id"
    t.string   "manageable_type", limit: 31
    t.string   "field_changed",   limit: 31
    t.integer  "action_type",                null: false
    t.string   "old_value"
    t.string   "new_value"
    t.datetime "created_at",                 null: false
  end

  create_table "messages", force: :cascade do |t|
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

  create_table "node_categories", force: :cascade do |t|
    t.string   "name",       limit: 15, null: false
    t.string   "slug",       limit: 31, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "node_categories", ["name"], name: "index_node_categories_on_name", unique: true, using: :btree
  add_index "node_categories", ["slug"], name: "index_node_categories_on_slug", unique: true, using: :btree

  create_table "nodes", force: :cascade do |t|
    t.integer  "node_category_id",                             null: false
    t.string   "name",             limit: 15,                  null: false
    t.string   "slug",             limit: 31,                  null: false
    t.string   "description",      limit: 255
    t.boolean  "need_login",                   default: false, null: false
    t.integer  "min_group",                    default: 0,     null: false
    t.integer  "min_role",                     default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["name"], name: "index_nodes_on_name", unique: true, using: :btree
  add_index "nodes", ["slug"], name: "index_nodes_on_slug", unique: true, using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "receiver_id",                     null: false
    t.integer  "n_type",                          null: false
    t.boolean  "is_read",         default: false, null: false
    t.integer  "reason_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",                      null: false
    t.datetime "deleted_at"
  end

  add_index "notifications", ["deleted_at"], name: "index_notifications_on_deleted_at", using: :btree
  add_index "notifications", ["is_read"], name: "index_notifications_on_is_read", using: :btree
  add_index "notifications", ["receiver_id"], name: "index_notifications_on_receiver_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.integer  "topic_id",                       null: false
    t.integer  "author_id",                      null: false
    t.integer  "quoted_reply_id"
    t.text     "content",                        null: false
    t.integer  "position",                       null: false
    t.integer  "appreciation_count", default: 0, null: false
    t.datetime "created_at",                     null: false
    t.datetime "deleted_at"
  end

  add_index "replies", ["author_id"], name: "index_replies_on_author_id", using: :btree
  add_index "replies", ["deleted_at"], name: "index_replies_on_deleted_at", using: :btree

  create_table "topics", force: :cascade do |t|
    t.integer  "node_id",                                    null: false
    t.integer  "author_id",                                  null: false
    t.integer  "status",                         default: 1, null: false
    t.integer  "refresher_id",                               null: false
    t.string   "title",              limit: 127,             null: false
    t.integer  "click_count",                    default: 0, null: false
    t.integer  "reply_count",                    default: 0, null: false
    t.integer  "favorite_count",                 default: 0, null: false
    t.integer  "appreciation_count",             default: 0, null: false
    t.text     "content",                                    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "priority",                                   null: false
  end

  add_index "topics", ["author_id"], name: "index_topics_on_author_id", using: :btree
  add_index "topics", ["priority"], name: "index_topics_on_priority", using: :btree
  add_index "topics", ["status"], name: "index_topics_on_status", using: :btree

  create_table "user_avatars", primary_key: "owner_id", force: :cascade do |t|
    t.boolean "is_enabled",                 default: true, null: false
    t.string  "filename",        limit: 31
    t.string  "third_party_url"
  end

  create_table "user_daily_logins", force: :cascade do |t|
    t.integer "user_id",                         null: false
    t.integer "day",                             null: false
    t.integer "successive_days", default: 1,     null: false
    t.boolean "is_awarded",      default: false, null: false
  end

  add_index "user_daily_logins", ["user_id", "day"], name: "index_user_daily_logins_on_user_id_and_day", unique: true, using: :btree
  add_index "user_daily_logins", ["user_id"], name: "index_user_daily_logins_on_user_id", using: :btree

  create_table "user_login_histories", force: :cascade do |t|
    t.integer  "user_id",               null: false
    t.string   "ip",         limit: 16, null: false
    t.datetime "created_at",            null: false
  end

  add_index "user_login_histories", ["user_id"], name: "index_user_login_histories_on_user_id", using: :btree

  create_table "user_profiles", primary_key: "owner_id", force: :cascade do |t|
    t.string  "name",         limit: 15
    t.boolean "gender"
    t.string  "headline",     limit: 63
    t.string  "field",        limit: 15
    t.string  "company",      limit: 63
    t.string  "university",   limit: 63
    t.string  "city",         limit: 31
    t.string  "website",      limit: 127
    t.string  "email",        limit: 127
    t.integer "qq"
    t.string  "weibo",        limit: 63
    t.string  "wechat",       limit: 31
    t.string  "linkedin",     limit: 127
    t.string  "zhihu",        limit: 31
    t.string  "douban",       limit: 31
    t.string  "renren",       limit: 31
    t.string  "introduction", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "nickname",               limit: 8,              null: false
    t.integer  "group",                  limit: 2, default: 1,  null: false
    t.integer  "role",                   limit: 2, default: 1,  null: false
    t.integer  "fortune",                          default: 0,  null: false
    t.integer  "topic_count",                      default: 0,  null: false
    t.integer  "reply_count",                      default: 0,  null: false
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
