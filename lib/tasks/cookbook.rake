namespace :cookbook do
  desc "Load the api by parsing the taglibs in the Hobo plugin"
  task :load_api_docs => :environment do
    ApiDocLoader.load
  end

  desc "Rebuild agility.markdown"
  task :rebuild_agility => :environment do
    #    GitorialsController::TITLES.each do |dir, desc|
    dir = 'agility'    
    gitlogp = `cd #{RAILS_ROOT}/gitorials/#{dir}; git pack-refs --all ; git log --unified=5 --reverse gitorial-001^..HEAD`
    refs = File.read("#{RAILS_ROOT}/gitorials/#{dir}/.git/packed-refs")
    gitorial = Gitorial.new(gitlogp, "http://github.com/bryanlarsen/agility-gitorial/commit/", "/patches/agility", refs)
    f=open("#{RAILS_ROOT}/gitorials/#{dir}.markdown", "w")
    f.write(gitorial.to_s)
    f.close
  end

  desc "git pull all plugins/submodules (except for non-Hobo project)"
  task :pull_all => :environment do
    ['vendor/plugins/paperclip_with_hobo', 'vendor/plugins/hobo', 'gitorials/agility', 'public/patches/agility', 'taglibs/hoboyui', 'taglibs/hobo-contrib', 'taglibs/hobo-jquery'].each {|sub|
      sh "cd #{sub} && git fetch origin && git merge origin/master"
    }
  end
end
