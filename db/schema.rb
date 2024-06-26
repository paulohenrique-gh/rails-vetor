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

ActiveRecord::Schema[7.1].define(version: 2024_04_24_001847) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "participant_instrument_id", null: false
    t.bigint "option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_answers_on_option_id"
    t.index ["participant_instrument_id"], name: "index_answers_on_participant_instrument_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.text "description", null: false
    t.integer "weight", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
    t.index ["weight", "question_id"], name: "index_options_on_weight_and_question_id", unique: true
  end

  create_table "participant_instruments", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "instrument_id", null: false
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
    t.bigint "psychologist_id", null: false
    t.index ["cpf"], name: "index_participants_on_cpf", unique: true
    t.index ["email"], name: "index_participants_on_email", unique: true
    t.index ["psychologist_id"], name: "index_participants_on_psychologist_id"
  end

  create_table "psychologists", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_psychologists_on_email", unique: true
    t.index ["reset_password_token"], name: "index_psychologists_on_reset_password_token", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instrument_id", null: false
    t.index ["instrument_id"], name: "index_questions_on_instrument_id"
  end

  add_foreign_key "answers", "options"
  add_foreign_key "answers", "participant_instruments"
  add_foreign_key "options", "questions"
  add_foreign_key "participant_instruments", "instruments"
  add_foreign_key "participant_instruments", "participants"
  add_foreign_key "participants", "psychologists"
  add_foreign_key "questions", "instruments"
end
