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

ActiveRecord::Schema.define(version: 20150323222934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banks", force: true do |t|
    t.date     "date"
    t.float    "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "timeline_id"
  end

  create_table "banks_teachers", id: false, force: true do |t|
    t.integer "bank_id"
    t.integer "teacher_id"
  end

  add_index "banks_teachers", ["bank_id", "teacher_id"], name: "index_banks_teachers_on_bank_id_and_teacher_id", using: :btree

  create_table "base_timelines", force: true do |t|
    t.integer  "year"
    t.string   "half",       limit: 1
    t.string   "tcc",        limit: 1
    t.string   "json"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

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

  create_table "item_timelines", force: true do |t|
    t.string   "status"
    t.string   "file"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "item_base_timeline_id"
    t.integer  "timeline_id"
  end

  create_table "logins", force: true do |t|
    t.string   "login"
    t.string   "password"
    t.integer  "access"
    t.integer  "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "ra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.string   "access"
    t.string   "lattes"
    t.string   "atuacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  create_table "timelines", force: true do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "base_timeline_id"
    t.integer  "bank_id"
  end

end
