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

ActiveRecord::Schema.define(version: 3) do

  create_table "job_parameters", force: :cascade do |t|
    t.datetime "signedin_at",                                    null: false
    t.integer  "statuses_count",   limit: 4,                     null: false
    t.datetime "registered_at",                                  null: false
    t.integer  "collect_method",   limit: 4,                     null: false
    t.text     "archive_url",      limit: 65535
    t.boolean  "protect_reply",    limit: 1,     default: false
    t.boolean  "protect_favorite", limit: 1,     default: false
    t.date     "collect_from"
    t.date     "collect_to"
    t.string   "start_message",    limit: 255
    t.string   "finish_message",   limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "user_id",    limit: 8,  null: false
    t.string   "aasm_state", limit: 30, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "jobs", ["aasm_state"], name: "index_clean_them_all_jobs_on_aasm_state", using: :btree
  add_index "jobs", ["user_id"], name: "index_clean_them_all_jobs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "token",      limit: 255, null: false
    t.string   "secret",     limit: 255, null: false
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "collect_and_destroy_job_credentials", force: :cascade do |t|
    t.string   "consumer_key",        limit: 255, null: false
    t.string   "consumer_secret",     limit: 255, null: false
    t.string   "access_token",        limit: 255, null: false
    t.string   "access_token_secret", limit: 255, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "collect_and_destroy_job_parameters", force: :cascade do |t|
    t.datetime "signedin_at",                                    null: false
    t.integer  "statuses_count",   limit: 4,                     null: false
    t.datetime "registered_at",                                  null: false
    t.integer  "collect_method",   limit: 4,                     null: false
    t.text     "archive_url",      limit: 65535
    t.boolean  "protect_reply",    limit: 1,     default: false
    t.boolean  "protect_favorite", limit: 1,     default: false
    t.date     "collect_from"
    t.date     "collect_to"
    t.string   "start_message",    limit: 255
    t.string   "finish_message",   limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "collect_and_destroy_jobs", force: :cascade do |t|
    t.string   "aasm_state",    limit: 255
    t.integer  "handle",        limit: 4
    t.integer  "collect_count", limit: 4,   default: 0
    t.integer  "filter_count",  limit: 4,   default: 0
    t.integer  "destroy_count", limit: 4,   default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "collect_and_destroy_schema_migrations", id: false, force: :cascade do |t|
    t.string "version", limit: 191, null: false
  end

  add_index "collect_and_destroy_schema_migrations", ["version"], name: "collect_and_destroy_unique_schema_migrations", unique: true, using: :btree

end
