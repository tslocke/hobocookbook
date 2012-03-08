class PluginsController < ApplicationController
  
  caches_page :index, :show

  TITLES = begin
             titles = ActiveSupport::OrderedHash.new
             Dir["#{Rails.root}/taglibs/*"].map {|fn|
               bfn=File.basename(fn)
               titles[bfn]=bfn.titleize
             }
             titles
           end
  
  def show    
    plugin       = params[:plugin].gsub(/[^a-z_\-]/, '')
    if plugin=="rapid"
      redirect_to "/api_taglibs"
      return
    end
    filename     = "#{Rails.root}/taglibs/#{plugin}/README.markdown"
    @title       = TITLES[plugin]
    @content     = HoboFields::Types::MarkdownString.new(File.read(filename))
    @libs        = ApiTaglib.library_is(plugin)
    @last_update = last_update filename
  end

end
