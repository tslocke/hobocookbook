class MoveTagDefsTo14 < ActiveRecord::Migration
  def self.up
    create_table :api_taglibs_14 do |t|
      t.string   :name
      t.text     :short_description
      t.text     :description
      t.string   :edit_link
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :plugin_id
    end
    add_index :api_taglibs_14, [:plugin_id]

    create_table :api_tag_comments_14 do |t|
      t.text     :body
      t.boolean  :markdown
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :api_tag_def_id
      t.integer  :user_id
    end
    add_index :api_tag_comments_14, [:api_tag_def_id]
    add_index :api_tag_comments_14, [:user_id]

    create_table :api_plugins_14 do |t|
      t.string   :name
      t.text     :short_description
      t.text     :description
      t.string   :edit_link_base
      t.string   :edit_link
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :api_tag_defs_14 do |t|
      t.string   :tag
      t.boolean  :extension
      t.boolean  :polymorphic
      t.string   :for_type
      t.text     :short_description
      t.text     :description
      t.text     :tag_attributes
      t.text     :tag_parameters
      t.string   :merge_attrs
      t.string   :merge_params
      t.text     :source
      t.string   :edit_link
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :taglib_id
    end
    add_index :api_tag_defs_14, [:taglib_id]
  end

  def self.down
    drop_table :api_taglibs_14
    drop_table :api_tag_comments_14
    drop_table :api_plugins
    drop_table :api_tag_defs_14
  end
end
