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

ActiveRecord::Schema.define(:version => 20120311165826) do

  create_table "answers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.integer  "question_id"
    t.text     "body"
    t.boolean  "markdown"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["recipe_id"], :name => "index_answers_on_recipe_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "api_plugins_14", :force => true do |t|
    t.string   "name"
    t.text     "short_description"
    t.text     "description"
    t.string   "edit_link_base"
    t.string   "edit_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "api_tag_comments", :force => true do |t|
    t.text     "body"
    t.boolean  "markdown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "api_tag_def_id"
    t.integer  "user_id"
  end

  create_table "api_tag_comments_14", :force => true do |t|
    t.text     "body"
    t.boolean  "markdown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "api_tag_def_id"
    t.integer  "user_id"
  end

  add_index "api_tag_comments_14", ["api_tag_def_id"], :name => "index_api_tag_comments_14_on_api_tag_def_id"
  add_index "api_tag_comments_14", ["user_id"], :name => "index_api_tag_comments_14_on_user_id"

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

  create_table "api_tag_defs_14", :force => true do |t|
    t.string   "tag"
    t.boolean  "extension"
    t.boolean  "polymorphic"
    t.string   "for_type"
    t.text     "short_description"
    t.text     "description"
    t.text     "tag_attributes"
    t.text     "tag_parameters"
    t.string   "merge_attrs"
    t.string   "merge_params"
    t.text     "source"
    t.string   "edit_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taglib_id"
  end

  add_index "api_tag_defs_14", ["taglib_id"], :name => "index_api_tag_defs_14_on_taglib_id"

  create_table "api_taglibs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "short_description"
    t.string   "library"
  end

  create_table "api_taglibs_14", :force => true do |t|
    t.string   "name"
    t.text     "short_description"
    t.text     "description"
    t.string   "edit_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plugin_id"
  end

  add_index "api_taglibs_14", ["plugin_id"], :name => "index_api_taglibs_14_on_plugin_id"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.boolean  "markdown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "recipe_id"
  end

  add_index "comments", ["recipe_id"], :name => "index_comments_on_recipe_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "images", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipe_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size",    :limit => 4
    t.datetime "image_updated_at"
  end

  add_index "images", ["recipe_id"], :name => "index_images_on_recipe_id"

  create_table "questions", :force => true do |t|
    t.text     "description"
    t.boolean  "markdown"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "subject"
  end

  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "recipes", ["user_id"], :name => "index_recipes_on_user_id"

  create_table "taggings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tag_id"
    t.integer  "recipe_id"
  end

  add_index "taggings", ["recipe_id"], :name => "index_taggings_on_recipe_id"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

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

  add_index "users", ["state"], :name => "index_users_on_state"

end
