desc "Update the gitorials"
task :update_gitorials => :environment do
  GitorialsController::TITLES.each do |dir, desc|
    gitlogp = `cd #{RAILS_ROOT}/gitorials/#{dir}; git log -p --reverse gitorial-001^..HEAD`
    gitorial = Gitorial.new(gitlogp,
                            "http://github.com/bryanlarsen/agility-gitorial/commit/",
                            "#{RAILS_ROOT}/gitorials/#{dir}/.git/refs/tags")
    f=open("#{RAILS_ROOT}/gitorials/#{dir}.markdown", "w")
    f.write(gitorial.to_s)
    f.close
  end
end
