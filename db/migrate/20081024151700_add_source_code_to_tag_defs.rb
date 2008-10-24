class AddSourceCodeToTagDefs < ActiveRecord::Migration
  def self.up
    add_column :api_tag_defs, :source, :text
  end

  def self.down
    remove_column :api_tag_defs, :source
  end
end
