require 'English'

module ApiDocLoader

  #  TAGLIB_HOME = "#{RAILS_ROOT}/vendor/plugins/hobo/hobo/taglibs"
#  TAGLIB_HOME = "#{Rails.root}/vendor/hobo13/hobo/lib/hobo/rapid/taglibs"
  TAGLIB_HOME = "#{Hobo.root}/lib/hobo/rapid/taglibs"
  INTERNAL_PLUGINS = [ HoboRapid, HoboJquery, HoboClean, HoboCleanAdmin]
  PLUGINS_HOME = "#{Rails.root}/taglibs"

  class Taglib < Dryml::DrymlDoc::Taglib


    def api_taglib(api_plugin)
      ApiTaglib.new(:name => name, :short_description => comment_intro_html, :description => comment_rest_html, :plugin => api_plugin)
    end

    def api_tagdefs(api_taglib, edit_link)
      tag_defs.map do |tag_def|
        tag_def.api_tagdef(api_taglib, edit_link)
      end.select{|t| t}
    end

  end

  class Helper
    include Rails.application.routes.url_helpers
    include ActionView::Helpers
    def link(tag)
      link_to("<#{tag.tag}>", {:controller => :api_tag_defs, :action => :tagdef, :plugin => tag.taglib.plugin.name, :taglib => tag.taglib.name, :tag => tag.tag}, {:class => "tag-link"})
    end
  end



  class TagDef < Dryml::DrymlDoc::TagDef

    def api_tagdef(owner, edit_link)
      return if no_doc?
      t = ApiTagDef.find_or_initialize_by_tag_and_for_type_and_taglib_id(name, for_type, owner.id)
      t.taglib = owner
      t.edit_link = edit_link
      t.attributes = { :tag => name, :extension => extension?, :polymorphic => polymorphic?,
                       :short_description => comment_intro_html,
                       :description => comment_rest_html,
                       :for_type => for_type,
                       :tag_attributes => attributes, :tag_parameters => parameters,
                       :merge_params => merge_params, :merge_attrs => merge_attrs,
                       :source => source }
      ApiDocLoader.all_tags << name
      t
    end
  end

  def self.all_tags
    @all_tags ||= []
  end

  def self.create_taglib(plugin, dir, name)
    filename = "#{dir}/#{name}.dryml"
    taglib = ApiDocLoader::Taglib.new(dir, filename, name)
    api_taglib = taglib.api_taglib(plugin)
    api_taglib.edit_link = File.join(plugin.edit_link_base, filename[(filename.length - dir.length - 1)..-1])
    api_taglib.tags = taglib.api_tagdefs(api_taglib, api_taglib.edit_link)
    taglib.tag_defs.clear

    (Dir["#{dir}/*.dryml"] - ["#{dir}/#{name}.dryml"]).sort.map {|filename|
      taglib.parse_file filename
      edit_link = File.join(plugin.edit_link_base, filename[(filename.length - dir.length - 1)..-1])
      api_taglib.tags += taglib.api_tagdefs(api_taglib, edit_link)
      taglib.tag_defs.clear
    }

    unless api_taglib.tags.blank?
      api_taglib.save!
      plugin.taglibs << api_taglib
    end
    api_taglib
  end

  def self.load
    clear

    [Dryml,HoboRapid,HoboJquery,HoboJqueryUi,HoboClean,HoboSimpleColor,HoboTreeTable,SelectOneOrNewDialog].each_with_index do |mod, position|
      plugin = ApiPlugin.new
      plugin.dir = mod.root
      plugin.name = mod.name.underscore
      plugin.position = position+1
      plugin.edit_link_base = mod::EDIT_LINK_BASE
      readme_file = Dir["#{plugin.dir}/README*"].first
      plugin.edit_link = File.join(plugin.edit_link_base, File.basename(readme_file))
      readme = File.read(readme_file)
      if readme =~ /(.*?\n)^#/m
        plugin.short_description = Maruku.new($1).to_html
        plugin.description = Maruku.new($POSTMATCH).to_html
      else
        plugin.short_description = Maruku.new(readme).to_html
        plugin.description = ""
      end

      ApiDocLoader.create_taglib(plugin, "#{plugin.dir}/taglibs", plugin.name)

      Dir["#{plugin.dir}/taglibs/*/"].sort.each do |dir|
        ApiDocLoader.create_taglib(plugin, dir[0..-2], File.basename(dir))
      end

      plugin.save!

    end

    ApiTagDef.all.each do |tag|
      b = Proc.new do |t|
        tt=ApiTagDef.find_by_tag($1)
        if tt.nil?
          unless %w(def div ul select li td th span br ol img textarea).include?($1)
            puts "Could not link to #{$1} in #{tag.tag}"
          end
          t
        else
          Helper.new.link(tt)
        end
      end
      re = /<code>&lt;([-a-zA-Z0-9]*)[!:]*?\/?&gt;<\/code>/
      tag.short_description = tag.short_description.gsub(re, &b)
      tag.description = tag.description.gsub(re, &b)
      tag.save!
    end
  end

  def self.clear
    ApiPlugin.delete_all
    ApiTaglib.delete_all
    ApiTagDef.delete_all
  end

end

