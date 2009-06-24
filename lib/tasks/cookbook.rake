namespace :cookbook do
  desc "Load the api by parsing the taglibs in the Hobo plugin"
  task :load_api_docs => :environment do
    ApiDocLoader.load
  end

  desc "Rebuild agility.markdown"
  task :rebuild_agility => :environment do
    #    GitorialsController::TITLES.each do |dir, desc|
    Gitorial.new("#{RAILS_ROOT}/gitorials/agility", "http://github.com/bryanlarsen/agility-gitorial/commit/", "/patches/agility").process.each do |filename, markdown|
      next if markdown==""
      f=open("#{RAILS_ROOT}/gitorials/#{filename}", "w")
      f.write(markdown)
      f.close
    end
  end

  desc "git pull all plugins/submodules (except for non-Hobo project)"
  task :pull_all => :environment do
    ['vendor/plugins/paperclip_with_hobo', 'vendor/plugins/hobo', 'public/patches/agility', 'taglibs/hoboyui', 'taglibs/hobo-contrib', 'taglibs/hobo-jquery'].each {|sub|
      sh "cd #{sub} && git fetch origin && git merge origin/master"
    }
    sh "cd gitorials/agility && git fetch origin && git checkout -f origin/master"
  end

  desc "do all update tasks"
  task :update => [:environment, :pull_all, :load_api_docs, :rebuild_agility] do
    true
  end
end
