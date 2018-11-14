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

ActiveRecord::Schema.define(version: 2018_11_14_215941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "variables", default: {}
    t.string "parsed_name", default: ""
    t.boolean "correct", default: false
    t.bigint "question_id"
    t.hstore "last_chosen_variables", default: {}
    t.index ["last_chosen_variables"], name: "index_answers_on_last_chosen_variables", using: :gin
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["variables"], name: "index_answers_on_variables", using: :gin
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "acronym"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id"
    t.hstore "random_questions", default: {}
    t.text "description", default: ""
    t.string "date", default: ""
    t.integer "time_limit", default: 90
    t.index ["course_id"], name: "index_exams_on_course_id"
    t.index ["random_questions"], name: "index_exams_on_random_questions", using: :gin
  end

  create_table "exams_questions", id: false, force: :cascade do |t|
    t.bigint "exam_id", null: false
    t.bigint "question_id", null: false
    t.index ["exam_id", "question_id"], name: "index_exams_questions_on_exam_id_and_question_id"
    t.index ["question_id", "exam_id"], name: "index_exams_questions_on_question_id_and_exam_id"
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "questions", force: :cascade do |t|
    t.text "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tags", default: [], array: true
    t.integer "points", default: 0
    t.string "category", default: "multiple_choice"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "courses", "users"
  add_foreign_key "questions", "users"
end
