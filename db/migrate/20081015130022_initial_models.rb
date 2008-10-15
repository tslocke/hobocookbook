class InitialModels < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :recipe_id
      t.integer  :question_id
    end
    
    create_table :comments do |t|
      t.text     :body
      t.boolean  :markdown
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :recipe_id
    end
    
    create_table :images do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :recipe_id
    end
    
    create_table :questions do |t|
      t.text     :description
      t.boolean  :markdown
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    
    create_table :recipes do |t|
      t.string   :name
      t.text     :body
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    
    create_table :tags do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    create_table :taggings do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :tag_id
      t.integer  :recipe_id
    end
    
    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :username
      t.string   :email_address
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state, :default => "active"
      t.datetime :key_timestamp
    end
  end

  def self.down
    drop_table :answers
    drop_table :comments
    drop_table :images
    drop_table :questions
    drop_table :recipes
    drop_table :tags
    drop_table :taggings
    drop_table :users
  end
end
