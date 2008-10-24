class AddingModelsForApiReferece < ActiveRecord::Migration
  def self.up
    create_table :api_tag_defs do |t|
      t.string   :name
      t.boolean  :extension
      t.boolean  :polymorphic
      t.string   :for_type
      t.text     :comment
      t.text     :tag_attributes
      t.text     :tag_parameters
      t.string   :merge_attrs
      t.string   :merge_params
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :taglib_id
    end
    
    create_table :api_taglibs do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :api_tag_defs
    drop_table :api_taglibs
  end
end
