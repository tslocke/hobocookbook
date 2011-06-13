class ApplicationController < ActionController::Base
  protect_from_forgery

#  helper :all # include all helpers, all the time


  before_filter :login_required, :only => [:new, :edit]

  private

  def last_update(filename)
    Dir.chdir(File.open("#{RAILS_ROOT}/git-path").read.chomp) do
      head = File.open("#{RAILS_ROOT}/git-version").read.chomp
      commit = `git rev-list #{head} #{filename} | head -n 1`
      date_s = `git show --pretty=format:%cD #{commit} | head -n 1`
      date_s ? Date.parse(date_s) : ""
    end
  end
end
