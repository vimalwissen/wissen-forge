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

ActiveRecord::Schema[8.1].define(version: 2025_12_12_144000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "due_date"
    t.string "title"
    t.bigint "training_id", null: false
    t.datetime "updated_at", null: false
    t.index ["training_id"], name: "index_assignments_on_training_id"
  end

  create_table "badges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "criteria"
    t.string "image_url"
    t.integer "level"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.boolean "attendance"
    t.datetime "completion_date"
    t.datetime "created_at", null: false
    t.integer "score"
    t.integer "status"
    t.bigint "training_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["training_id"], name: "index_enrollments_on_training_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "questions"
    t.bigint "training_id", null: false
    t.datetime "updated_at", null: false
    t.index ["training_id"], name: "index_quizzes_on_training_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.datetime "created_at", null: false
    t.string "file_url"
    t.integer "grade"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["assignment_id"], name: "index_submissions_on_assignment_id"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.integer "assignment_scope", default: 0
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.string "department_target"
    t.text "description"
    t.datetime "end_time"
    t.string "instructor"
    t.integer "mode"
    t.string "skills", default: [], array: true
    t.datetime "start_time"
    t.integer "status"
    t.string "target_departments", default: [], array: true
    t.integer "target_user_ids", default: [], array: true
    t.string "title"
    t.integer "training_type"
    t.datetime "updated_at", null: false
  end

  create_table "user_badges", force: :cascade do |t|
    t.datetime "awarded_at"
    t.bigint "badge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id"
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "department"
    t.string "designation"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "manager_id"
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assignments", "trainings"
  add_foreign_key "enrollments", "trainings"
  add_foreign_key "enrollments", "users"
  add_foreign_key "quizzes", "trainings"
  add_foreign_key "submissions", "assignments"
  add_foreign_key "submissions", "users"
  add_foreign_key "user_badges", "badges"
  add_foreign_key "user_badges", "users"
end
