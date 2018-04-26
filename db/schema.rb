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

ActiveRecord::Schema.define(version: 20180402132540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_schools", force: :cascade do |t|
    t.string   "name"
    t.integer  "nb_max_student"
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "class_schools", ["name"], name: "index_class_schools_on_name", using: :btree

  create_table "elements", force: :cascade do |t|
    t.string   "name"
    t.string   "for_what"
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "elements", ["for_what"], name: "index_elements_on_for_what", using: :btree
  add_index "elements", ["name"], name: "index_elements_on_name", using: :btree

  create_table "grade_contexts", force: :cascade do |t|
    t.string   "name"
    t.string   "goal"
    t.string   "min_value"
    t.string   "max_value"
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "grade_contexts", ["name"], name: "index_grade_contexts_on_name", using: :btree

  create_table "gradecontexts", force: :cascade do |t|
    t.string   "name"
    t.string   "goal"
    t.string   "min_value"
    t.string   "max_value"
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "gradecontexts", ["name"], name: "index_gradecontexts_on_name", using: :btree

  create_table "grades", force: :cascade do |t|
    t.integer  "grade_grade_context_id", limit: 8
    t.integer  "grade_matter_id",        limit: 8
    t.integer  "grade_student_id",       limit: 8
    t.date     "grade_date"
    t.string   "value"
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "grades", ["grade_grade_context_id"], name: "index_grades_on_grade_grade_context_id", using: :btree
  add_index "grades", ["grade_matter_id"], name: "index_grades_on_grade_matter_id", using: :btree
  add_index "grades", ["grade_student_id"], name: "index_grades_on_grade_student_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "usage_id"
    t.text     "description"
    t.integer  "location_nb_max_person"
    t.string   "custo"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locations", ["name"], name: "index_locations_on_name", using: :btree

  create_table "matter_durations", force: :cascade do |t|
    t.string   "name"
    t.integer  "matter_duration_level_id", limit: 8
    t.integer  "value"
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "matter_durations", ["name"], name: "index_matter_durations_on_name", using: :btree

  create_table "matters", force: :cascade do |t|
    t.string   "name"
    t.integer  "matter_type_id"
    t.integer  "matter_duration"
    t.integer  "matter_nb_max_student"
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "matters", ["name"], name: "index_matters_on_name", using: :btree

  create_table "notebook_teachers", force: :cascade do |t|
    t.integer  "notebook_id", limit: 8
    t.integer  "teacher_id",  limit: 8
    t.string   "custo"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "notebook_teachers", ["notebook_id"], name: "index_notebook_teachers_on_notebook_id", using: :btree
  add_index "notebook_teachers", ["teacher_id"], name: "index_notebook_teachers_on_teacher_id", using: :btree

  create_table "notebooks", force: :cascade do |t|
    t.string   "name"
    t.text     "notebooktext"
    t.integer  "student_id",   limit: 8
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "notebooks", ["name"], name: "index_notebooks_on_name", using: :btree
  add_index "notebooks", ["student_id"], name: "index_notebooks_on_student_id", using: :btree

  create_table "presents", force: :cascade do |t|
    t.integer  "student_id",   limit: 8
    t.integer  "schedule_id",  limit: 8
    t.integer  "teaching_id",  limit: 8
    t.string   "present_type"
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "presents", ["schedule_id"], name: "index_presents_on_schedule_id", using: :btree
  add_index "presents", ["student_id"], name: "index_presents_on_student_id", using: :btree
  add_index "presents", ["teaching_id"], name: "index_presents_on_teaching_id", using: :btree

  create_table "responsibles", force: :cascade do |t|
    t.string   "name"
    t.string   "person_status"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "adress"
    t.string   "postalcode"
    t.string   "town"
    t.string   "phone1"
    t.string   "phone2"
    t.date     "birthday"
    t.text     "description"
    t.string   "custo"
    t.integer  "type_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "responsibles", ["name"], name: "index_responsibles_on_name", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "custo"
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "schedule_type"
    t.datetime "start_time"
    t.integer  "schedule_father_id",   limit: 8
    t.integer  "schedule_teaching_id", limit: 8
    t.string   "custo"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "schedules", ["start_time"], name: "index_schedules_on_start_time", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_responsibles", force: :cascade do |t|
    t.integer  "student_id",     limit: 8
    t.integer  "responsible_id", limit: 8
    t.string   "custo"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "student_responsibles", ["responsible_id"], name: "index_student_responsibles_on_responsible_id", using: :btree
  add_index "student_responsibles", ["student_id"], name: "index_student_responsibles_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   ""
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "adress"
    t.string   "postalcode"
    t.string   "town"
    t.string   "phone1"
    t.string   "phone2"
    t.date     "birthday"
    t.integer  "student_class_school_id", limit: 8
    t.text     "description"
    t.string   "custo"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "students", ["email"], name: "index_students_on_email", using: :btree
  add_index "students", ["name"], name: "index_students_on_name", using: :btree

  create_table "teacher_matters", force: :cascade do |t|
    t.integer  "teacher_id", limit: 8
    t.integer  "matter_id",  limit: 8
    t.string   "custo"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "teacher_matters", ["matter_id"], name: "index_teacher_matters_on_matter_id", using: :btree
  add_index "teacher_matters", ["teacher_id"], name: "index_teacher_matters_on_teacher_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.string   "name"
    t.string   "person_status"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "adress"
    t.string   "postalcode"
    t.string   "town"
    t.string   "phone1"
    t.string   "phone2"
    t.date     "birthday"
    t.text     "description"
    t.string   "custo"
    t.integer  "defmatter_id"
    t.integer  "defgradecontext_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "teachings", force: :cascade do |t|
    t.string   "name"
    t.integer  "teaching_class_school_id",   limit: 8
    t.integer  "teaching_teacher_id",        limit: 8
    t.integer  "teaching_matter_id",         limit: 8
    t.string   "teaching_domain_id"
    t.datetime "teaching_start_time"
    t.string   "teaching_repetition"
    t.integer  "teaching_repetition_number"
    t.text     "description"
    t.string   "custo"
    t.integer  "teaching_location_id",       limit: 8
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "teachings", ["name"], name: "index_teachings_on_name", using: :btree
  add_index "teachings", ["teaching_class_school_id"], name: "index_teachings_on_teaching_class_school_id", using: :btree
  add_index "teachings", ["teaching_matter_id"], name: "index_teachings_on_teaching_matter_id", using: :btree
  add_index "teachings", ["teaching_teacher_id"], name: "index_teachings_on_teaching_teacher_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "role"
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

end
