class AddShortDescriptionToTaglibs < ActiveRecord::Migration
  def self.up
    add_column :api_taglibs, :short_description, :text
  end

  def self.down
    remove_column :api_taglibs, :short_description
  end
end
