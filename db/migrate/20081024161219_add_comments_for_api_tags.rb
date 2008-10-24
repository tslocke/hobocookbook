class AddCommentsForApiTags < ActiveRecord::Migration
  def self.up
    create_table :api_tag_comments do |t|
      t.text     :body
      t.boolean  :markdown
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :api_tag_def_id
      t.integer  :user_id
    end
  end

  def self.down
    drop_table :api_tag_comments
  end
end
