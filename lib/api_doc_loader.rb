module ApiDocLoader

#  TAGLIB_HOME = "#{RAILS_ROOT}/vendor/plugins/hobo/hobo/taglibs"
#  TAGLIB_HOME = "#{Rails.root}/vendor/hobo13/hobo/lib/hobo/rapid/taglibs"
  TAGLIB_HOME = "#{Hobo.root}/lib/hobo/rapid/taglibs"
  PLUGINS_HOME = "#{Rails.root}/taglibs"

  class Taglib < Dryml::DrymlDoc::Taglib

    def load_into_database(library)
      taglib = ApiTaglib.create :name => name, :short_description => comment_intro_html, :description => comment_rest_html, :library => library
      tag_defs.*.load_into_database(taglib)
    end

  end


  class TagDef < Dryml::DrymlDoc::TagDef

    def load_into_database(owner)
      return if no_doc?
      #debugger
#      puts "owner: #{owner} name: #{name} for_type: #{for_type}"
      t = ApiTagDef.find_or_create_by_tag_and_for_type(name, for_type)
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
    taglibs = Dryml::DrymlDoc.load_taglibs TAGLIB_HOME, ApiDocLoader::Taglib
    taglibs.*.load_into_database("rapid")

    Dir["#{PLUGINS_HOME}/*"].each {|plugin_dir|
      plugin = File.basename(plugin_dir)
      Dir["#{plugin_dir}/taglibs/*.dryml"].map {|filename|
        ApiDocLoader::Taglib.new("#{plugin_dir}/taglibs", filename).load_into_database(plugin)
      }
    }

    ApiTagDef.destroy_all("tag not in (#{all_tags.*.inspect.join(', ')})")
  end

  def self.clear
    ApiTaglib.delete_all
  end

end

