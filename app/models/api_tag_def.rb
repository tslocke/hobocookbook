class ApiTagDef < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    tag            :string
    extension      :boolean
    polymorphic    :boolean
    for_type       :string
                 
    description    :html
    tag_attributes :serialized, :class => Array
    tag_parameters :serialized, :class => Array
                 
    merge_attrs    :string
    merge_params   :string
    
    timestamps
  end
  
  belongs_to :taglib, :class_name => "ApiTaglib"
  
  def def_line
    "<#{extension? ? 'extend' : 'def'} tag='#{tag}'#{' polymorphic' if polymorphic?}#{' for=\'' + for_type + '\'' if for_type}>"
  end
  
  def name
    "<#{tag}#{' for=\'' + for_type[0..15] + '\'' if for_type}>"
  end
  
  

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
