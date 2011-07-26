class TutorialsController < ApplicationController
  
  caches_page :index, :show
  
  TITLES = begin
             titles = ActiveSupport::OrderedHash.new
             [['two-minutes',    "Thingybob - the two minute Hobo app"],
              ['screencast',     "Screencast"],
              ['agility',        "Agility - demonstrates all Hobo features"],
              ['gitorial',       "Agility git sidebar"],
              ['subsite',        "An admin subsite on a generic Rails app"]
             ].each do |title, desc|
               titles[title]=desc
             end
             titles
           end
  
  def show
    tutorial     = params[:tutorial].gsub(/[^a-z_\-]/, '')
    filename     = "gitorials/#{tutorial}.markdown"
    @title       = TITLES[tutorial]
    @content     = HoboFields::Types::MarkdownString.new(File.read("#{RAILS_ROOT}/#{filename}"))
    @last_update = last_update filename
  end

end
