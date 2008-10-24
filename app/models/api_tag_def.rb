class ApiTagDef < ActiveRecord::Base

  hobo_model # Don't put anything above this

  include NameAsId
  
  fields do
    tag               :string, :name => true
    extension         :boolean
    polymorphic       :boolean
    for_type          :string
                 
    short_description :html
    description       :html
    tag_attributes    :serialized, :class => Array
    tag_parameters    :serialized, :class => Array
                      
    merge_attrs       :string
    merge_params      :string
    
    timestamps
  end
  
  belongs_to :taglib, :class_name => "ApiTaglib"
  
  def def_line
    "<#{extension? ? 'extend' : 'def'} tag='#{tag}'#{' polymorphic' if polymorphic?}#{' for=\'' + for_type + '\'' if for_type}>"
  end
  
  def short_def_line
    "<#{tag}#{' for=\'' + for_type[0..15] + '\'' if for_type}>"
  end
  
  def all_attributes
    tag_attributes | merged_attributes
  end
  
  def merge_attrs_tagdef
    @merged_attrs_tagdef ||= ApiTagDef.find_by_tag(merge_attrs)
  end

  def merge_params_tagdef
    @merged_attrs_tagdef ||= ApiTagDef.find_by_tag(merge_attrs)
  end
  
  def merged_attributes
    merge_attrs_tagdef._?.all_attributes || []
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
