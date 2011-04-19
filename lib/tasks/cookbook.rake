namespace :cookbook do
  desc "Load the api by parsing the taglibs in the Hobo plugin"
  task :load_api_docs => :environment do
    ApiDocLoader.load
  end

  desc "Rebuild agility.markdown"
  task :rebuild_agility => :environment do
    #    GitorialsController::TITLES.each do |dir, desc|
    Gitorial.new("#{RAILS_ROOT}/gitorials/agility", "http://github.com/Hobo/agility-gitorial/commit/", "/patches/agility").process.each do |filename, markdown|
      next if markdown==""
      f=open("#{RAILS_ROOT}/gitorials/#{filename}", "w")
      f.write(markdown)
      f.close
    end
  end

  desc "Rebuild generator documentation"
  task :rebuild_generator_docs => :environment do
    ManualController::SUBTITLES['generators'].each do |gen, title|
      raw = `#{RAILS_ROOT}/script/generate #{gen} --help`
      out = "Generators -- #{title.gsub('_', '\_')}\n{: .document-title}\n\n" +
        raw.gsub(/^(\w(\w|\s)*):(.*)/) {|s| "\n## #{$1}\n\n    #{$3}\n"}.
        gsub("#{RAILS_ROOT}", ".")
      Dir.mkdir("#{RAILS_ROOT}/manual/generators") rescue nil
      open("#{RAILS_ROOT}/manual/generators/#{gen}.markdown", "w") do |f|
        f.write(out)
      end
    end
  end

  desc "git pull all plugins/submodules (except for non-Hobo project)"
  task :pull_all => :environment do
    ['vendor/plugins/paperclip_with_hobo', 'public/patches/agility', 'taglibs/hoboyui', 'taglibs/hobo-contrib', 'taglibs/hobo-jquery', 'taglibs/imaginary-dryml'].each {|sub|
      sh "cd #{sub} && git fetch origin && git checkout origin/master"
    }
    sh "cd vendor/plugins/hobo && git fetch origin && git checkout origin/1-0-stable"
    sh "rm -rf gitorials/agility ; git submodule update gitorials/agility ; cd gitorials/agility && git checkout -f origin/master"
  end

  desc "do all update tasks"
  task :update => [:environment, :pull_all, :load_api_docs, :rebuild_agility, :rebuild_generator_docs] do
    true
  end
end
