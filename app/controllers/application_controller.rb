# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # :secret => 'fa42ca8790f4b08ffbaf2b0b854bdbcc'
  
  before_filter :login_required, :only => [:new, :edit]

  private
  
  def last_update(filename)
    Dir.chdir(RAILS_ROOT) do
      date_s = `git log -1 #{filename}`.match(/^Date:\s*(.*)$/)._?[1]
      date_s ? Date.parse(date_s) : ""
    end
  end
    

end
