class ChangeTagNameFieldToTag < ActiveRecord::Migration
  def self.up
    rename_column :api_tag_defs, :name, :tag
  end

  def self.down
    rename_column :api_tag_defs, :tag, :name
  end
end
