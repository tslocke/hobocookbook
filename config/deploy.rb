set :application, "cookbook"
set :domain, "cookbook-staging.hobocentral.net"
set :deploy_to, "/home/newcookbook"
set :repository, "git://github.com/bryanlarsen/hobocookbook"
set :revision, "origin/master"

set :user, "cookbook"
set :domain, "#{user}@cookbook-staging.hobocentral.net"

namespace :vlad do
  desc 'Restart Passenger'
  remote_task :start_app, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  remote_task :generate_taglibs do
    run "cd #{current_release}; RAILS_ENV=production rake hobo:generate_taglibs"
  end

  desc 'reload api tags'
  remote_task :update_cookbook do
    run "cd #{current_release}; RAILS_ENV=production rake cookbook:load_api_docs"
  end
end
