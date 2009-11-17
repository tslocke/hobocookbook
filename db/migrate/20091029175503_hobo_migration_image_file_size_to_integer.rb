class HoboMigrationImageFileSizeToInteger < ActiveRecord::Migration
  def self.up
    add_column :images, :image_updated_at, :datetime
    change_column :images, :image_file_size, :integer, :limit => 4
  end

  def self.down
    remove_column :images, :image_updated_at
    change_column :images, :image_file_size, :string
  end
end
