class AgilityController < ApplicationController

  def show
    filename = "gitorials/agility.markdown"
    @page = (params[:page]).to_i
    markdown = File.read("#{Rails.root}/#{filename}")
    m2 = markdown.match(/^gitorial-#{'%03i' % (@page-1)}.*?$(.*)^gitorial-#{'%03i' % @page}/m)
    m2 = m2.nil? ? markdown.match(/^gitorial-#{'%03i' % (@page-2)}.*?$(.*)^gitorial-#{'%03i' % @page}/m)[1] : m2[1]
    @content = HoboFields::MarkdownString.new(m2)
  end

end
