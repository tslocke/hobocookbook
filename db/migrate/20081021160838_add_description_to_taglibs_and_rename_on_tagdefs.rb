class AddDescriptionToTaglibsAndRenameOnTagdefs < ActiveRecord::Migration
  def self.up
    rename_column :api_tag_defs, :comment, :description
    
    add_column :api_taglibs, :description, :text
  end

  def self.down
    rename_column :api_tag_defs, :description, :comment
    
    remove_column :api_taglibs, :description
  end
end
