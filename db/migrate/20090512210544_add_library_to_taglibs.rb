class AddLibraryToTaglibs < ActiveRecord::Migration
  def self.up
    add_column :api_taglibs, :library, :string
  end

  def self.down
    remove_column :api_taglibs, :library
  end
end
