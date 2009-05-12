class TutorialsController < ApplicationController
  
  caches_page :index, :show
  
  TITLES = begin
             titles = ActiveSupport::OrderedHash.new
             [['agility',       "Agility - a simple story manager"]].each do |title, desc|
               titles[title]=desc
             end
             titles
           end
  
  def show
    filename     = "#{RAILS_ROOT}/gitorials/#{params[:tutorial]}.markdown"
    @title       = TITLES[params[:tutorial]]
    @content     = HoboFields::MarkdownString.new(File.read(filename))
    @last_update = last_update filename
  end

end
