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

ActiveRecord::Schema.define(version: 20160407084706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "title"
    t.string   "slug"
    t.integer  "blogger_id"
    t.string   "option"
    t.text     "wysiwyg_content"
  end

  add_index "articles", ["blogger_id"], name: "index_articles_on_blogger_id", using: :btree
  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree

  create_table "bloggers", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "slug"
  end

  add_index "bloggers", ["email"], name: "index_bloggers_on_email", unique: true, using: :btree
  add_index "bloggers", ["slug"], name: "index_bloggers_on_slug", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "name",       default: "Anon"
    t.text     "content"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "article_id"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "subscribers", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "blogger_id"
  end

  add_index "subscribers", ["blogger_id"], name: "index_subscribers_on_blogger_id", using: :btree

  add_foreign_key "articles", "bloggers"
  add_foreign_key "comments", "articles"
  add_foreign_key "subscribers", "bloggers"
end
