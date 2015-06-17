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

ActiveRecord::Schema.define(version: 20150617070207) do

  create_table "dusers", force: true do |t|
    t.string   "uid"
    t.string   "name"
    t.integer  "c_follower"
    t.integer  "c_m_do"
    t.integer  "c_m_wish"
    t.integer  "c_m_collect"
    t.integer  "c_doulist"
    t.string   "error"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "c_review"
    t.string   "did"
  end

end
