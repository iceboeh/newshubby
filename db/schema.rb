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

ActiveRecord::Schema.define(version: 20150429075513) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

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
    t.text     "quote"
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
    t.text     "text"
    t.text     "q_what_you_do"
    t.text     "q_how_you_achieve"
    t.text     "q_clients"
    t.text     "differentiation"
    t.text     "problem_solved"
    t.text     "business_model"
    t.text     "competitors"
    t.boolean  "interview_done"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "press_release_id"
  end

  create_table "newsrooms", force: true do |t|
    t.string   "company_name"
    t.string   "website"
    t.string   "press_phone"
    t.string   "press_email"
    t.date     "founded"
    t.string   "q_who_are_you"
    t.text     "q_what_you_do"
    t.text     "q_how_you_achieve"
    t.text     "q_clients"
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
    t.text     "business_model"
    t.text     "competitors"
    t.text     "differentiation"
    t.text     "problem_solved"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "twitter"
    t.integer  "subscription_id"
    t.string   "code"
    t.boolean  "term_agreement"
  end

  add_index "newsrooms", ["email"], name: "index_newsrooms_on_email", unique: true
  add_index "newsrooms", ["reset_password_token"], name: "index_newsrooms_on_reset_password_token", unique: true
  add_index "newsrooms", ["slug"], name: "index_newsrooms_on_slug", unique: true

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "role"
    t.text     "presentation"
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

  create_table "press_releases", force: true do |t|
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pressrelease_type_id"
    t.text     "specifics"
    t.integer  "newsroom_id"
    t.string   "slug"
    t.string   "hex"
    t.boolean  "exclusive",            default: true
    t.datetime "embargo"
  end

  add_index "press_releases", ["slug"], name: "index_press_releases_on_slug"

  create_table "pressreleaes_fields", force: true do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.text     "question"
    t.text     "example"
    t.text     "prefill"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pressrelease_type_id"
    t.text     "tip"
  end

  create_table "pressrelease_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "required_fields"
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
    t.integer  "press_release_id"
  end

end
