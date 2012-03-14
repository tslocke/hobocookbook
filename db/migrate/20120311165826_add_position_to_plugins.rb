class AddPositionToPlugins < ActiveRecord::Migration
  def self.up
    add_column :api_plugins_14, :position, :integer
  end

  def self.down
    remove_column :api_plugins_14, :position
  end
end
