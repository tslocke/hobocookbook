desc "Load the api by parsing the taglibs in the Hobo plugin"
task :load_api_docs => :environment do
  ApiDocLoader.load
end