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

ActiveRecord::Schema[7.1].define(version: 2024_04_21_193247) do
  create_table "instruments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.text "description", null: false
    t.integer "weight", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "participant_instruments", force: :cascade do |t|
    t.integer "participant_id", null: false
    t.integer "instrument_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "finished_at"
    t.integer "score"
    t.index ["instrument_id"], name: "index_participant_instruments_on_instrument_id"
    t.index ["participant_id"], name: "index_participant_instruments_on_participant_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name", null: false
    t.string "cpf", null: false
    t.string "email", null: false
    t.date "date_of_birth", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_participants_on_cpf", unique: true
    t.index ["email"], name: "index_participants_on_email", unique: true
  end

  create_table "question_sets", force: :cascade do |t|
    t.integer "participant_instrument_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_instrument_id"], name: "index_question_sets_on_participant_instrument_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "description", null: false
    t.integer "question_set_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_set_id"], name: "index_questions_on_question_set_id"
  end

  add_foreign_key "options", "questions"
  add_foreign_key "participant_instruments", "instruments"
  add_foreign_key "participant_instruments", "participants"
  add_foreign_key "question_sets", "participant_instruments"
  add_foreign_key "questions", "question_sets"
end
