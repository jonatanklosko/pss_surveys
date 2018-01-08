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

ActiveRecord::Schema.define(version: 20180108154011) do

  create_table "competitions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "wca_competition_id", null: false
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "competitors_count", null: false
    t.datetime "surveys_closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surveys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "wca_user_id", null: false
    t.string "wca_id"
    t.string "name", null: false
    t.string "avatar_thumb_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
