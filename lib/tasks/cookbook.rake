require "#{Rails.root}/lib/api_doc_loader"
namespace :cookbook do
  desc "Load the api by parsing the taglibs in the Hobo plugin"
  task :load_api_docs => :environment do
    ApiDocLoader.load
  end

  desc "Rebuild agility.markdown"
  task :rebuild_agility => :environment do
    #    GitorialsController::TITLES.each do |dir, desc|
    Gitorial.new("#{Rails.root}/gitorials/agility", "http://github.com/Hobo/agility-gitorial/commit/", "/patches/agility").process.each do |filename, markdown|
      next if markdown==""
      f=open("#{Rails.root}/gitorials/#{filename}", "w")
      f.write(markdown)
      f.close
    end
  end

  desc "Rebuild generator documentation"
  task :rebuild_generator_docs => :environment do
    ManualController::SUBTITLES['generators'].each do |gen, title|
      #raw = `cd rails3app; rvm 1.9.2-p0 exec rails g hobo:#{gen} --help`
      #raw = `cd rails3app; exec rails g hobo:#{gen} --help`
      raw = `bundle exec rails g hobo:#{gen} --help`
      out = "Generators -- #{title.gsub('_', '\_')}\n{: .document-title}\n\n" +
        raw.gsub(/^(\w(\w|\s)*):(.*)/) {|s| "\n## #{$1}\n\n    #{$3}\n"}.
        gsub("#{Rails.root}", ".")
      Dir.mkdir("#{Rails.root}/manual/generators") rescue nil
      open("#{Rails.root}/manual/generators/#{gen}.markdown", "w") do |f|
        f.write(out)
      end
    end
  end

  desc "git pull all plugins/submodules (except for non-Hobo project)"
  task :pull_all => :environment do
    ['vendor/plugins/paperclip_with_hobo', 'public/patches/agility', 'taglibs/hoboyui', 'taglibs/hobo-contrib', 'taglibs/imaginary-dryml'].each {|sub|
      sh "cd #{sub} && git fetch origin && git checkout origin/master"
    }
    sh 'cd taglibs/hobo-jquery && git fetch origin && git checkout origin/rails3'
    #sh 'cd vendor/hobo13 && git fetch origin && git checkout origin/rails3'
    #sh "cd vendor/plugins/hobo && git fetch origin && git checkout origin/1-0-stable"
    sh "rm -rf gitorials/agility ; git submodule update gitorials/agility ; cd gitorials/agility && git checkout -f origin/master"
  end

  desc "do all update tasks"
  task :update => [:environment, :pull_all, :load_api_docs, :rebuild_agility, :rebuild_generator_docs] do
    true
  end
end

