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

ActiveRecord::Schema.define(version: 5) do

  create_table "job_parameters", id: :bigint, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "signedin_at", null: false
    t.integer "statuses_count", null: false
    t.datetime "registered_at", null: false
    t.string "collect_method", null: false
    t.text "archive_url"
    t.boolean "protect_reply", default: false
    t.boolean "protect_favorite", default: false
    t.date "collect_from"
    t.date "collect_to"
    t.text "start_message"
    t.text "finish_message"
  end

  create_table "jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.bigint "user_id", null: false
    t.string "transition_state", null: false
    t.string "progression_state", null: false
    t.integer "collect_count", default: 0
    t.integer "destroy_count", default: 0
    t.boolean "notified_start_message", default: false
    t.boolean "notified_finish_message", default: false
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["progression_state"], name: "index_jobs_on_progression_state"
    t.index ["transition_state"], name: "index_jobs_on_transition_state"
    t.index ["user_id", "transition_state"], name: "index_jobs_on_user_id_and_transition_state"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "timeline_fragments", id: :bigint, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.bigint "job_id", null: false
    t.index ["job_id"], name: "index_timeline_fragments_on_job_id"
  end

  create_table "users", id: :bigint, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "token", null: false
    t.string "secret", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
