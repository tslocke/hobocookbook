class TutorialsController < ApplicationController
  
  caches_page :index, :show
  
  TITLES = begin
             titles = ActiveSupport::OrderedHash.new
             [['two-minutes',    "Thingybob - the two minute Hobo app"],
              ['agility',       "Agility - a simple story manager"],
              ['gitorial',      "Agility sidebar - using git"],
              ['hobo-as-plugin', "Agility sidebar - using Hobo as a plugin"]
             ].each do |title, desc|
               titles[title]=desc
             end
             titles
           end
  
  def show
    tutorial     = params[:tutorial].gsub(/[^a-z_\-]/, '')
    filename     = "#{RAILS_ROOT}/gitorials/#{tutorial}.markdown"
    @title       = TITLES[tutorial]
    @content     = HoboFields::MarkdownString.new(File.read(filename))
    @last_update = last_update filename
  end

end
