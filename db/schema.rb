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

ActiveRecord::Schema.define(version: 20180310175926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string "wca_competition_id", null: false
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "competitors_count", null: false
    t.datetime "surveys_closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remark"
  end

  create_table "competitions_organizers", force: :cascade do |t|
    t.bigint "organizer_id"
    t.bigint "competition_id"
    t.index ["competition_id"], name: "index_competitions_organizers_on_competition_id"
    t.index ["organizer_id"], name: "index_competitions_organizers_on_organizer_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "survey_answers", force: :cascade do |t|
    t.bigint "survey_id"
    t.bigint "survey_question_id"
    t.integer "rating", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_answers_on_survey_id"
    t.index ["survey_question_id"], name: "index_survey_answers_on_survey_question_id"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.string "question", null: false
    t.text "description"
    t.boolean "delegate", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "competition_id"
    t.string "secret_id"
    t.string "competitor_email", null: false
    t.integer "competitor_competitions_count"
    t.boolean "delegate", default: false, null: false
    t.datetime "submitted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_surveys_on_competition_id"
    t.index ["secret_id"], name: "index_surveys_on_secret_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "wca_user_id", null: false
    t.string "wca_id"
    t.string "name", null: false
    t.string "avatar_thumb_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
