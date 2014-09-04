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

ActiveRecord::Schema.define(version: 20140902122337) do

  create_table "codes", force: true do |t|
    t.string   "code"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_launches", force: true do |t|
    t.integer  "newsroom_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "company_name"
    t.string   "website"
    t.string   "press_phone"
    t.string   "press_email"
    t.date     "founded"
    t.string   "quote"
    t.string   "link1"
    t.string   "link2"
    t.boolean  "exclusive",          default: true
    t.string   "file1_file_name"
    t.string   "file1_content_type"
    t.integer  "file1_file_size"
    t.datetime "file1_updated_at"
    t.string   "file2_file_name"
    t.string   "file2_content_type"
    t.integer  "file2_file_size"
    t.datetime "file2_updated_at"
    t.string   "file3_file_name"
    t.string   "file3_content_type"
    t.integer  "file3_file_size"
    t.datetime "file3_updated_at"
    t.date     "embargo"
    t.string   "hex"
    t.date     "launch"
    t.string   "caption_link1"
    t.string   "caption_link2"
    t.string   "caption_file1"
    t.string   "caption_file2"
    t.string   "caption_file3"
  end

  create_table "founders", force: true do |t|
    t.string   "name"
    t.string   "role"
    t.string   "presentation"
    t.string   "newsroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "fundings", force: true do |t|
    t.string   "investment_type"
    t.string   "name"
    t.date     "date"
    t.integer  "amount"
    t.string   "newsroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", force: true do |t|
    t.string   "link"
    t.integer  "company_launches_id"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_launch_id"
  end

  create_table "newsrooms", force: true do |t|
    t.string   "company_name"
    t.string   "website"
    t.string   "press_phone"
    t.string   "press_email"
    t.date     "founded"
    t.string   "q_who_are_you"
    t.string   "q_what_you_do"
    t.string   "q_how_you_achieve"
    t.string   "q_clients"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "slug"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "location"
    t.string   "business_model"
    t.string   "competitors"
    t.string   "differentiation"
    t.string   "problem_solved"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "twitter"
    t.integer  "subscription_id"
    t.string   "code"
  end

  add_index "newsrooms", ["email"], name: "index_newsrooms_on_email", unique: true
  add_index "newsrooms", ["reset_password_token"], name: "index_newsrooms_on_reset_password_token", unique: true
  add_index "newsrooms", ["slug"], name: "index_newsrooms_on_slug", unique: true

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "role"
    t.string   "presentation"
    t.string   "newsroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "founder"
  end

  create_table "plans", force: true do |t|
    t.string   "paymill_id"
    t.string   "name"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "plan_id"
    t.string   "email"
    t.string   "name"
    t.string   "paymill_id"
    t.integer  "newsroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "end"
  end

  create_table "uploads", force: true do |t|
    t.integer  "company_launch_id"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

end
