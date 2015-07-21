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

ActiveRecord::Schema.define(version: 20150721111632) do

  create_table "akas", force: true do |t|
    t.integer  "movie_id"
    t.string   "aka"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "celebrities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dusers", force: true do |t|
    t.string   "did"
    t.string   "uid"
    t.string   "name"
    t.integer  "c_follower"
    t.integer  "c_m_do"
    t.integer  "c_m_wish"
    t.integer  "c_m_collect"
    t.integer  "c_doulist"
    t.integer  "c_review"
    t.string   "error"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_celebrities", force: true do |t|
    t.integer  "movie_id"
    t.integer  "celebrity_id"
    t.string   "name"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_countries", force: true do |t|
    t.integer  "movie_id"
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_languages", force: true do |t|
    t.integer  "movie_id"
    t.integer  "language_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_types", force: true do |t|
    t.integer  "movie_id"
    t.integer  "type_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: true do |t|
    t.string   "title"
    t.string   "cn_title"
    t.string   "original_title"
    t.float    "rating"
    t.string   "poster_url"
    t.string   "poster_id"
    t.string   "subtype"
    t.string   "pubyear"
    t.integer  "duration"
    t.string   "imdb_id"
    t.string   "summary"
    t.integer  "e_count"
    t.integer  "e_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
