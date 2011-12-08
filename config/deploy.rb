set :application, "cookbook"
set :domain,      "cookbook-staging.hobocentral.net"
# set :domain,      "li285-250.members.linode.com"
set :deploy_to,   "/home/cookbook-staging"
set :repository,  "git://github.com/tablatom/hobocookbook"
set :revision,    "origin/master"
set :skip_scm, false

set :user, "cookbook"
set :domain, "#{user}@cookbook-staging.hobocentral.net"

set :rake_cmd, "/opt/ruby-1.8.7-p334/bin/bundle exec  /opt/ruby-1.8.7-p334/bin/rake"
# set :rake_cmd, "/usr/local/rvm/bin/cookbook_rake"

namespace :vlad do
  desc 'Restart Passenger'
  remote_task :start_app, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc 'reload api tags'
  remote_task :update_cookbook do
    run " cd #{current_release}; RAILS_ENV=production #{rake_cmd} cookbook:load_api_docs"
#    run " cd #{current_release}; RAILS_ENV=production #{rake_cmd} cookbook:rebuild_generator_docs"
  end

  desc 'update secret in config/environment.rb'
  remote_task :update_secret do
    secret=`dd if=/dev/urandom bs=64 count=1`.unpack("Q8").map {|i| i.to_s(16)}.join("")
    run "cd #{current_release}/config; sed -i.bak -e's/REPLACE_ME_WITH_A_REAL_SECRET/#{secret}/' environment.rb"
  end

  desc 'save version'
  remote_task :save_version do
    run "cd #{scm_path}/repo; git rev-parse HEAD > #{current_release}/git-version"
    run "echo #{scm_path}/repo > #{current_release}/git-path"
  end

  remote_task :copy_config_files, :roles => :app do
    run "cp #{shared_path}/config/* #{current_release}/config/"
  end

  remote_task :update, :roles => :app do
    Rake::Task["vlad:copy_config_files"].invoke
    Rake::Task["vlad:save_version"].invoke
    Rake::Task["vlad:update_secret"].invoke
    Rake::Task["vlad:update_cookbook"].invoke
  end

end
