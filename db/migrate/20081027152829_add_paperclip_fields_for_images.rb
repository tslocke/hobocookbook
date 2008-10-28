class AddPaperclipFieldsForImages < ActiveRecord::Migration
  def self.up
    add_column :images, :image_file_name, :string
    add_column :images, :image_content_type, :string
    add_column :images, :image_file_size, :string
  end

  def self.down
    remove_column :images, :image_file_name
    remove_column :images, :image_content_type
    remove_column :images, :image_file_size
  end
end
