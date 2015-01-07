# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150107181719) do

  create_table "answers", force: true do |t|
    t.text     "title"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
  end

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
  end

  create_table "slides", force: true do |t|
    t.string   "title"
    t.text     "markdown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
  end

  create_table "test_histories", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "test_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.boolean  "correct"
  end

  create_table "tests", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
    t.integer  "user_id"
    t.integer  "mark"
    t.integer  "total"
    t.boolean  "passed"
  end

  create_table "users", force: true do |t|
    t.string   "email",                       null: false
    t.string   "crypted_password",            null: false
    t.string   "salt",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.text     "surname"
    t.boolean  "admin"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token"
  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
