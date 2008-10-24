class ApiTaglib < ActiveRecord::Base

  hobo_model # Don't put anything above this
  
  include NameAsId

  fields do
    name        :string
    description :html
    timestamps
  end

  has_many :tags, :class_name => "ApiTagDef", :foreign_key => "taglib_id"
  
  set_default_order "name"
    

  # --- Hobo Permissions --- #

  def creatable_by?(creator)
    creator.administrator?
  end

  def updatable_by?(updater, updated)
    updater.administrator?
  end

  def deletable_by?(deleter)
    deleter.administrator?
  end

  def viewable_by?(viewer, field)
    true
  end

end
