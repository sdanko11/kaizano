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

ActiveRecord::Schema.define(version: 20140204182825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_forms", force: true do |t|
    t.string   "name"
    t.string   "email_address", null: false
    t.text     "message",       null: false
    t.string   "subject",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name",                     null: false
    t.string   "location"
    t.string   "event_url"
    t.text     "description",              null: false
    t.integer  "user_id"
    t.datetime "time"
    t.datetime "event_date",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_password", limit: 8, null: false
  end

  add_index "events", ["event_password"], name: "index_events_on_event_password", unique: true, using: :btree

  create_table "multi_choice_answers", force: true do |t|
    t.string   "answer_submission",        null: false
    t.integer  "multi_choice_question_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multi_choice_questions", force: true do |t|
    t.string   "question_body", null: false
    t.integer  "event_id",      null: false
    t.text     "answer_a",      null: false
    t.text     "answer_b",      null: false
    t.text     "answer_c",      null: false
    t.text     "answer_d",      null: false
    t.string   "answer",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_answers", force: true do |t|
    t.integer  "question_id"
    t.text     "answer_body", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_comments", force: true do |t|
    t.string   "body",        null: false
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "body",                             null: false
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_votes_count", default: 0
  end

  create_table "reviews", force: true do |t|
    t.string   "feedback_comments"
    t.integer  "rating",            null: false
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "twitter_handle"
    t.string   "linked_in_url"
    t.string   "phone_number"
    t.string   "avatar"
    t.text     "about_me",                            null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
