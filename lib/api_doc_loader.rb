module ApiDocLoader
  
  TAGLIB_HOME = "#{RAILS_ROOT}/vendor/plugins/hobo/hobo/taglibs"
  
  class Taglib < Hobo::Dryml::DrymlDoc::Taglib
    
    def load_into_database
      taglib = ApiTaglib.new :name => name, :description => comment_html
      tag_defs.*.load_into_database(taglib)
      taglib.save unless taglib.description.blank? && taglib.tags.empty?
    end
    
  end

  
  class TagDef < Hobo::Dryml::DrymlDoc::TagDef
    
    def load_into_database(owner)
      return if no_doc?
      
      owner.tags.build :tag => name, :extension => extension?, :polymorphic => polymorphic?,
                       :short_description => comment_intro_html,
                       :description => comment_rest_html, 
                       :for_type => for_type, 
                       :tag_attributes => attributes, :tag_parameters => parameters,
                       :merge_params => merge_params, :merge_attrs => merge_attrs
    end
    
  end
  
  
  def self.load
    clear
    taglibs = Hobo::Dryml::DrymlDoc.load_taglibs TAGLIB_HOME, ApiDocLoader::Taglib
    taglibs.*.load_into_database
    taglibs
  end
  
  def self.clear
    ApiTaglib.delete_all
    ApiTagDef.delete_all
  end
  
end