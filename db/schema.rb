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

ActiveRecord::Schema.define(version: 2020_06_28_062400) do

  create_table "report_titles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
  end

  create_table "report_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string "system_id", null: false
    t.integer "report_type_id", null: false
    t.integer "report_title_id", null: false
    t.string "special_title"
    t.date "issue_date", null: false
    t.date "limit_date"
    t.string "filename"
    t.string "path"
    t.datetime "created_at", null: false
    t.index ["report_title_id"], name: "index_reports_on_report_title_id"
    t.index ["report_type_id"], name: "index_reports_on_report_type_id"
    t.index ["system_id"], name: "index_reports_on_system_id", unique: true
  end

  add_foreign_key "reports", "report_titles"
  add_foreign_key "reports", "report_types"
end
