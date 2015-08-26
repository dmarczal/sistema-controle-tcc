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

ActiveRecord::Schema.define(version: 20150826000823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "approvals", force: true do |t|
    t.integer  "type_approval_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "bank_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "dropbox_file"
  end

  create_table "bank_notes", force: true do |t|
    t.integer  "bank_id"
    t.integer  "teacher_id"
    t.float    "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bank_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banks", force: true do |t|
    t.date     "date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "timeline_id"
    t.string   "file"
    t.string   "_type"
    t.integer  "bank_status_id"
  end

  add_index "banks", ["timeline_id"], name: "banks_timeline_idx", using: :btree

  create_table "banks_teachers", id: false, force: true do |t|
    t.integer "bank_id"
    t.integer "teacher_id"
  end

  add_index "banks_teachers", ["bank_id", "teacher_id"], name: "index_banks_teachers_on_bank_id_and_teacher_id", using: :btree
  add_index "banks_teachers", ["bank_id"], name: "banks_teachers_bank_id_idx", using: :btree
  add_index "banks_teachers", ["teacher_id"], name: "banks_teachers_teacher_id_idx", using: :btree

  create_table "base_timelines", force: true do |t|
    t.integer  "year"
    t.string   "half",       limit: 1
    t.string   "tcc",        limit: 1
    t.string   "json"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "item_base_timelines", force: true do |t|
    t.string   "description",      limit: 500
    t.string   "title",            limit: 50
    t.string   "_type",            limit: 20
    t.date     "date"
    t.string   "link"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "base_timeline_id"
  end

  add_index "item_base_timelines", ["base_timeline_id"], name: "item_base_timelines_base_timeline_id_idx", using: :btree

  create_table "item_timelines", force: true do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "item_base_timeline_id"
    t.integer  "timeline_id"
    t.integer  "status_item_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "dropbox_file"
  end

  add_index "item_timelines", ["item_base_timeline_id"], name: "item_timelines_item_base_timeline_id_idx", using: :btree
  add_index "item_timelines", ["timeline_id"], name: "item_timelines_timeline_id_idx", using: :btree

  create_table "notices", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notices", ["slug"], name: "index_notices_on_slug", unique: true, using: :btree

  create_table "orientations", force: true do |t|
    t.string   "title"
    t.date     "date"
    t.text     "description"
    t.integer  "timeline_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "orientations", ["timeline_id"], name: "orientations_timeline_id_idx", using: :btree

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "passwords", force: true do |t|
    t.string   "password"
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "passwords", ["student_id"], name: "index_passwords_on_student_id", using: :btree
  add_index "passwords", ["teacher_id"], name: "index_passwords_on_teacher_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_items", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "ra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.string   "login"
  end

  create_table "teacher_timelines", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "timeline_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "teacher_timelines", ["teacher_id"], name: "teacher_timelines_teacher_id_idx", using: :btree
  add_index "teacher_timelines", ["timeline_id"], name: "teacher_timelines_timeline_id_idx", using: :btree

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.string   "lattes"
    t.string   "atuacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.string   "login"
    t.integer  "role_id"
  end

  add_index "teachers", ["role_id"], name: "teachers_role_id_idx", using: :btree

  create_table "timelines", force: true do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "base_timeline_id"
    t.integer  "bank_id"
    t.string   "title"
  end

  add_index "timelines", ["base_timeline_id"], name: "timelines_base_timeline_id_idx", using: :btree

  create_table "type_approvals", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "passwords", "students"
  add_foreign_key "passwords", "teachers"
end
