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

  desc 'run hobo:generate_taglibs'
  remote_task :generate_taglibs do
    run "cd #{current_release}; RAILS_ENV=production rake hobo:generate_taglibs"
  end

  desc 'reload api tags'
  remote_task :update_cookbook do
    run "cd #{current_release}; RAILS_ENV=production rake cookbook:load_api_docs"
  end

  desc 'update secret in config/environment.rb'
  remote_task :update_secret do
    secret=`dd if=/dev/urandom bs=64 count=1`.unpack("Q8").map {|i| i.to_s(16)}.join("")
    run "cd #{current_release}/config; sed -i.bak -e's/REPLACE_ME_WITH_A_REAL_SECRET/#{secret}/' environment.rb"
  end

  remote_task :update, :roles => :app do
    Rake::Task["vlad:update_secret"].invoke
    Rake::Task["vlad:generate_taglibs"].invoke
  end

end
