# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_20_060655) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "add_subject_to_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_add_subject_to_users_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "attempt_id", null: false
    t.string "chosen_option"
    t.boolean "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_id", null: false
    t.index ["attempt_id"], name: "index_answers_on_attempt_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "exercise_id"
    t.index ["exercise_id"], name: "index_attempts_on_exercise_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.integer "boardid"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name"
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "chaptersummaries", force: :cascade do |t|
    t.string "name"
    t.integer "numofexercises"
    t.float "progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.boolean "watched"
    t.string "description"
    t.boolean "upvote"
    t.boolean "downvote"
    t.string "notes"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chapter_id", null: false
    t.index ["chapter_id"], name: "index_contents_on_chapter_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.integer "total_duration"
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "questions"
    t.string "name"
    t.index ["chapter_id"], name: "index_exercises_on_chapter_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "otps", force: :cascade do |t|
    t.integer "otp"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_otps_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.string "solution"
    t.string "option_1"
    t.string "option_2"
    t.string "option_3"
    t.string "option_4"
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_questions_on_exercise_id"
  end

  create_table "standards", force: :cascade do |t|
    t.integer "classid"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.float "progress"
    t.index ["user_id"], name: "index_subjects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mobilenumber"
    t.string "name"
    t.string "dob"
    t.bigint "class_id"
    t.bigint "board_id"
    t.string "profilephoto"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "add_subject_to_users", "users"
  add_foreign_key "answers", "attempts"
  add_foreign_key "answers", "questions"
  add_foreign_key "attempts", "exercises"
  add_foreign_key "attempts", "users"
  add_foreign_key "chapters", "subjects"
  add_foreign_key "contents", "chapters"
  add_foreign_key "exercises", "chapters"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "otps", "users"
  add_foreign_key "questions", "exercises"
  add_foreign_key "subjects", "users"
end
