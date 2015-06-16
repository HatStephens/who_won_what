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

ActiveRecord::Schema.define(version: 20150616185944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fixture_group_users", force: :cascade do |t|
    t.integer  "fixture_id"
    t.integer  "group_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "fixture_group_users", ["fixture_id"], name: "index_fixture_group_users_on_fixture_id", using: :btree
  add_index "fixture_group_users", ["group_user_id"], name: "index_fixture_group_users_on_group_user_id", using: :btree

  create_table "fixtures", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
  end

  add_index "fixtures", ["group_id"], name: "index_fixtures_on_group_id", using: :btree

  create_table "group_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id", using: :btree
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "deleted_on"
    t.string   "date"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "match_players", force: :cascade do |t|
    t.integer  "match_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "goals"
    t.integer  "fixture_group_user_id"
  end

  add_index "match_players", ["fixture_group_user_id"], name: "index_match_players_on_fixture_group_user_id", using: :btree
  add_index "match_players", ["match_id"], name: "index_match_players_on_match_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "fixture_id"
  end

  add_index "matches", ["fixture_id"], name: "index_matches_on_fixture_id", using: :btree
  add_index "matches", ["group_id"], name: "index_matches_on_group_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "fixture_group_users", "fixtures"
  add_foreign_key "fixture_group_users", "group_users"
  add_foreign_key "fixtures", "groups"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "match_players", "fixture_group_users"
  add_foreign_key "match_players", "matches"
  add_foreign_key "matches", "fixtures"
  add_foreign_key "matches", "groups"
end
