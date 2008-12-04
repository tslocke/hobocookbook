class TutorialsController < ApplicationController
  
  caches_page :index, :show
  
  TITLES = ActiveSupport::OrderedHash.new [['agility',       "Agility - a simple story manager"]]
  
  def show
    tutorial     = params[:tutorial].gsub('[^a-z_]', '')
    filename     = "#{RAILS_ROOT}/tutorials/#{tutorial}.markdown"
    @title       = TITLES[tutorial]
    @content     = HoboFields::MarkdownString.new(File.read(filename))
    @last_update = last_update filename
  end

  private
  
  def last_update(filename)
    date_s = `git log -1 #{filename}`.match(/^Date:\s*(.*)$/)._?[1]
    date_s ? Date.parse(date_s) : ""
  end
  
end
