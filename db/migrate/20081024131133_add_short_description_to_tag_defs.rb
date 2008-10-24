class AddShortDescriptionToTagDefs < ActiveRecord::Migration
  def self.up
    add_column :api_tag_defs, :short_description, :text
  end

  def self.down
    remove_column :api_tag_defs, :short_description
  end
end
