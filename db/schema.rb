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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120812174426) do

  create_table "assignments", :force => true do |t|
    t.string    "assn"
    t.string    "instructions"
    t.integer   "user_id"
    t.integer   "student_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "active"
    t.boolean   "mlunch"
    t.boolean   "tlunch"
    t.boolean   "wlunch"
    t.boolean   "rlunch"
    t.boolean   "flunch"
    t.boolean   "mafter"
    t.boolean   "tafter"
    t.boolean   "wafter"
    t.boolean   "rafter"
    t.boolean   "fafter"
    t.string    "all"
    t.string    "comment"
    t.boolean   "long_term",    :default => false
  end

  add_index "assignments", ["student_id"], :name => "index_assignments_on_student_id"
  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"

  create_table "attendances", :force => true do |t|
    t.string    "section"
    t.string    "missingstudents"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
    t.string    "all"
  end

  add_index "attendances", ["user_id"], :name => "index_attendances_on_user_id"

  create_table "students", :force => true do |t|
    t.string    "name"
    t.text      "instructions"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "grade"
  end

  add_index "students", ["user_id"], :name => "index_students_on_user_id"

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "encrypted_password"
    t.string    "salt"
    t.boolean   "admin",              :default => false
    t.string    "secretcode"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
