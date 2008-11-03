class ApiTagDef < ActiveRecord::Base

  hobo_model # Don't put anything above this

  def self.find(*args)
    if args.first =~ /[a-zA-Z0-9_-]+/
      find_by_tag_and_for_type(args.first, nil)
    else
      super
    end
  end
  
  def to_param
    to_s
  end
  
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
    
    source            :text
    
    timestamps
  end
  
  belongs_to :taglib, :class_name => "ApiTaglib"
  has_many   :comments, :class_name => "ApiTagComment", :dependent => :destroy
  
  named_scope :no_for_type, :conditions => "for_type is null"
  
  def def_line
    "<#{extension? ? 'extend' : 'def'} tag='#{tag}'#{' polymorphic' if polymorphic?}#{' for=\'' + for_type + '\'' if for_type}>"
  end
  
  def short_def_line
    "<#{tag}#{' for=\'' + for_type + '\'' if for_type}>"
  end
  
  def typed_variants
    return [] if for_type
    ApiTagDef.find :all, :conditions => ["tag = ? AND (for_type is not null)", tag]
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

  def documented?
    !(description.blank? && short_description.blank?)
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
