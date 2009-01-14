# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090112154358) do

  create_table "answers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.integer  "question_id"
    t.text     "body"
    t.boolean  "markdown"
  end

  create_table "api_tag_comments", :force => true do |t|
    t.text     "body"
    t.boolean  "markdown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "api_tag_def_id"
    t.integer  "user_id"
  end

  create_table "api_tag_defs", :force => true do |t|
    t.string   "tag"
    t.boolean  "extension"
    t.boolean  "polymorphic"
    t.string   "for_type"
    t.text     "description"
    t.text     "tag_attributes"
    t.text     "tag_parameters"
    t.string   "merge_attrs"
    t.string   "merge_params"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taglib_id"
    t.text     "short_description"
    t.text     "source"
  end

  create_table "api_taglibs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "short_description"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.boolean  "markdown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "recipe_id"
  end

  create_table "images", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipe_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.string   "image_file_size"
  end

  create_table "questions", :force => true do |t|
    t.text     "description"
    t.boolean  "markdown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "subject"
  end

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "taggings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tag_id"
    t.integer  "recipe_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "username"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
  end

end
