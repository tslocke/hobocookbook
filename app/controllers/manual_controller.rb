class ManualController < ApplicationController
  
  caches_page :index, :manual_section
  
  TITLES = begin
             titles = ActiveSupport::OrderedHash.new
             [['to-do',        "To Do List"],
              ['dryml-guide',  "The DRYML Guide"],
              ['permissions',  "The Permission System"],
              ['controllers',  "Controllers and Routing"],
              ['lifecycles',   'Lifecycles'],
              ['viewhints',    'View Hints']].each do |title, desc|
                                                       titles[title] = desc
                                                   end
             titles
           end
  
  def manual_section
    section      = params[:section].gsub(/[^a-z_\-]/, '')
    filename     = "manual/#{section}.markdown"
    @title       = TITLES[section]
    @content     = HoboFields::MarkdownString.new(File.read("#{RAILS_ROOT}/#{filename}"))
    @last_update = last_update filename
  end

end
