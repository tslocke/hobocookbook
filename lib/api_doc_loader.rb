module ApiDocLoader
  
  TAGLIB_HOME = "#{RAILS_ROOT}/vendor/plugins/hobo/hobo/taglibs"
  
  class Taglib < Hobo::Dryml::DrymlDoc::Taglib
    
    def load_into_database
      taglib = ApiTaglib.create :name => name, :description => comment_html
      tag_defs.*.load_into_database(taglib)
    end
    
  end

  
  class TagDef < Hobo::Dryml::DrymlDoc::TagDef
    
    def load_into_database(owner)
      return if no_doc?
      
      t = ApiTagDef.find_or_create_by_tag(name)
      t.taglib = owner
      t.attributes = { :tag => name, :extension => extension?, :polymorphic => polymorphic?,
                       :short_description => comment_intro_html,
                       :description => comment_rest_html, 
                       :for_type => for_type, 
                       :tag_attributes => attributes, :tag_parameters => parameters,
                       :merge_params => merge_params, :merge_attrs => merge_attrs,
                       :source => source }
      t.save
      
      ApiDocLoader.all_tags << name
    end
    
  end
  
  def self.all_tags
    @all_tags ||= []
  end
  
  def self.load
    clear
    taglibs = Hobo::Dryml::DrymlDoc.load_taglibs TAGLIB_HOME, ApiDocLoader::Taglib
    taglibs.*.load_into_database
    taglibs
    
    ApiTagDef.destroy_all("tag not in (#{all_tags.*.inspect.join(', ')})")
  end
  
  def self.clear
    ApiTaglib.delete_all
  end
  
end