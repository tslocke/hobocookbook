class AllowOptionalMarkdownInAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :markdown, :boolean
  end

  def self.down
    remove_column :answers, :markdown
  end
end
