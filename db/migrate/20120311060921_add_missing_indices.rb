class AddMissingIndices < ActiveRecord::Migration
  def self.up
    add_index :comments, [:recipe_id]
    add_index :comments, [:user_id]
    add_index :questions, [:user_id]
    add_index :images, [:recipe_id]
    add_index :recipes, [:user_id]
    add_index :users, [:state]
    add_index :taggings, [:tag_id]
    add_index :taggings, [:recipe_id]
    add_index :answers, [:recipe_id]
    add_index :answers, [:question_id]
    add_index :answers, [:user_id]
  end

  def self.down
    remove_index :comments, :name => :index_comments_on_recipe_id rescue ActiveRecord::StatementInvalid
    remove_index :comments, :name => :index_comments_on_user_id rescue ActiveRecord::StatementInvalid
    remove_index :questions, :name => :index_questions_on_user_id rescue ActiveRecord::StatementInvalid
    remove_index :images, :name => :index_images_on_recipe_id rescue ActiveRecord::StatementInvalid
    remove_index :recipes, :name => :index_recipes_on_user_id rescue ActiveRecord::StatementInvalid
    remove_index :users, :name => :index_users_on_state rescue ActiveRecord::StatementInvalid
    remove_index :taggings, :name => :index_taggings_on_tag_id rescue ActiveRecord::StatementInvalid
    remove_index :taggings, :name => :index_taggings_on_recipe_id rescue ActiveRecord::StatementInvalid
    remove_index :answers, :name => :index_answers_on_recipe_id rescue ActiveRecord::StatementInvalid
    remove_index :answers, :name => :index_answers_on_question_id rescue ActiveRecord::StatementInvalid
    remove_index :answers, :name => :index_answers_on_user_id rescue ActiveRecord::StatementInvalid
  end
end
