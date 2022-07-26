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

ActiveRecord::Schema[7.0].define(version: 2022_07_23_121742) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "candidates", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_candidates_on_account_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "university_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["university_id"], name: "index_faculties_on_university_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professors", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_professors_on_account_id"
  end

  create_table "recruitments", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "professor_id", null: false
    t.bigint "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_recruitments_on_faculty_id"
    t.index ["professor_id"], name: "index_recruitments_on_professor_id"
  end

  create_table "researches", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.bigint "professor_id", null: false
    t.bigint "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_researches_on_faculty_id"
    t.index ["professor_id"], name: "index_researches_on_professor_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name", null: false
    t.text "note"
    t.bigint "prefecture_id", null: false
    t.text "url"
    t.boolean "active", default: false
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_universities_on_prefecture_id"
  end

  add_foreign_key "candidates", "accounts"
  add_foreign_key "faculties", "universities"
  add_foreign_key "professors", "accounts"
  add_foreign_key "recruitments", "faculties"
  add_foreign_key "recruitments", "professors"
  add_foreign_key "researches", "faculties"
  add_foreign_key "researches", "professors"
  add_foreign_key "universities", "prefectures"
end
