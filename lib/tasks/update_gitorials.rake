desc "Update the gitorials"
task :update_gitorials => :environment do
  GitorialsController::TITLES.each do |dir, desc|
    gitlogp = `cd #{RAILS_ROOT}/gitorials/#{dir}; git pack-refs --all ; git log --unified=5 --reverse gitorial-001^..HEAD`
    refs = File.read("#{RAILS_ROOT}/gitorials/#{dir}/.git/packed-refs")
    gitorial = Gitorial.new(gitlogp, "http://github.com/bryanlarsen/agility-gitorial/commit/", "/patches/agility", refs)
    f=open("#{RAILS_ROOT}/gitorials/#{dir}.markdown", "w")
    f.write(gitorial.to_s)
    f.close
  end
end
