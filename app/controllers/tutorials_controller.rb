class TutorialsController < ApplicationController
  
  caches_page :index, :show
  
  TITLES = begin
             titles = ActiveSupport::OrderedHash.new
             [['two-minutes',    ["Thingybob - the two minute Hobo app", "https://github.com/tablatom/hobocookbook/edit/master/gitorials/two-minutes.markdown"]],
              ['screencast',     ["Screencast", "https://github.com/tablatom/hobocookbook/edit/master/gitorials/screencast.markdown"]],
              ['agility',        ["Agility - demonstrates all Hobo features", nil]],
              ['gitorial',       ["Agility git sidebar", nil]],
              ['subsite',        ["An admin subsite on a generic Rails app", "https://github.com/tablatom/hobocookbook/edit/master/gitorials/subsite.markdown"]],
              ['caching',        ["How to use the caching tags", "https://github.com/tablatom/hobocookbook/edit/master/gitorials/caching.markdown"]]
             ].each do |title, desc|
               titles[title]=desc
             end
             titles
           end
  
  def show
    tutorial     = params[:tutorial].gsub(/[^a-z_\-]/, '')
    filename     = "gitorials/#{tutorial}.markdown"
    @title       = TITLES[tutorial][0]
    @content     = HoboFields::Types::MarkdownString.new(File.read("#{Rails.root}/#{filename}"))
    @last_update = last_update filename
    @edit_link   = TITLES[tutorial][1]
  end

  def self.titles
    ActiveSupport::OrderedHash[*TITLES.map {|k,v| [k, v[0]]}.flatten]
  end  

end
