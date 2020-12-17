# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_17_210525) do

  create_table "answer_templates", force: :cascade do |t|
    t.text "body"
    t.integer "question_template_id", null: false
    t.index ["question_template_id"], name: "index_answer_templates_on_question_template_id"
  end

  create_table "answers", force: :cascade do |t|
    t.integer "submission_id"
    t.integer "question_id"
    t.integer "user_id"
    t.integer "vote_count"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "guesses", force: :cascade do |t|
    t.integer "submission_id"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "question_template_id", null: false
    t.integer "likes", default: 0
  end

  create_table "joins", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plays", force: :cascade do |t|
    t.integer "trivia_id"
    t.integer "team_id"
    t.integer "submission_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_templates", force: :cascade do |t|
    t.text "body"
    t.text "correct_answer"
    t.text "question_type"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "trivium_id"
    t.text "body"
    t.text "answer_type"
    t.text "correct_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "trivium_id", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trivia", force: :cascade do |t|
    t.text "title", null: false
    t.text "body", null: false
    t.datetime "game_starts_at", null: false
    t.datetime "game_ends_at", null: false
    t.integer "questions_count", default: 0
    t.integer "likes_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "max_questions", default: 20, null: false
  end

  create_table "trivium_questions", force: :cascade do |t|
    t.integer "trivium_id", null: false
    t.integer "question_template_id", null: false
    t.index ["question_template_id"], name: "index_trivium_questions_on_question_template_id"
    t.index ["trivium_id"], name: "index_trivium_questions_on_trivium_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string "voteable_type"
    t.integer "voteable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "answer_templates", "question_templates"
  add_foreign_key "trivium_questions", "question_templates"
  add_foreign_key "trivium_questions", "trivia"
end
