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

ActiveRecord::Schema.define(:version => 20110828081259) do

  create_table "conclusions", :force => true do |t|
    t.integer  "job_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums_users", :id => false, :force => true do |t|
    t.integer "forum_id"
    t.integer "user_id"
  end

  create_table "jobs", :force => true do |t|
    t.integer  "author_id"
    t.integer  "forum_id"
    t.integer  "job_number"
    t.text     "description"
    t.string   "status",         :default => "open"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "due_date"
    t.time     "due_time"
    t.integer  "assigned_by_id"
  end

  create_table "jobs_handlers", :id => false, :force => true do |t|
    t.integer "job_id"
    t.integer "user_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "nick"
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",             :null => false
    t.string   "crypted_password",  :null => false
    t.string   "password_salt",     :null => false
    t.string   "persistence_token", :null => false
    t.integer  "role_id"
  end

end
