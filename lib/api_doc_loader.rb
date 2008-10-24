module ApiDocLoader
  
  TAGLIB_HOME = "#{RAILS_ROOT}/vendor/plugins/hobo/hobo/taglibs"
  
  class Taglib < Hobo::Dryml::DrymlDoc::Taglib
    
    def load_into_database
      owner = ApiTaglib.create :name => name, :description => comment_html
      tag_defs.*.load_into_database(owner)
    end
    
  end

  
  class TagDef < Hobo::Dryml::DrymlDoc::TagDef
    
    def load_into_database(owner)
      owner.tags.create :tag => name, :extension => extension?, :polymorphic => polymorphic?,
                        :description => comment_html, :for_type => for_type, 
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