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

ActiveRecord::Schema.define(version: 20200309010050) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.bigint "user_id"
    t.bigint "topic_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_comments_on_topic_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "tag_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "topic_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id", "tag_id"], name: "index_tag_relationships_on_topic_id_and_tag_id", unique: true
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "topics"
  add_foreign_key "comments", "users"
  add_foreign_key "topics", "users"
end
