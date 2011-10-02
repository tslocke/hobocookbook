source 'http://rubygems.org'

gem 'rails', '3.0.9'
gem 'rake', '0.8.7'
gem 'will_paginate', '3.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'mysql'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
gem 'yard'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
group :development do
  # set to 0.43 due to problem with .45 see https://github.com/rails/rails/pull/1671
  # gem 'ruby-debug'
  # gem 'ruby-debug-ide'
  # gem 'linecache', '0.43'
end

gem "maruku"

#temp workaround for hash_secret issue see https://groups.google.com/forum/#!topic/hobousers/dS4VT_lyVIY
#gem "paperclip", "~> 2.3"
gem 'paperclip', :git => "git://github.com/jeanmartin/paperclip.git", :branch => "master"
#required by paperclip
gem "cocaine"

gem "hobo", "1.3.0.RC2", :git => "git://github.com/tablatom/hobo.git", :branch => "rails3"

group :development do
  gem "vlad", :require => false
  gem "vlad-git", :git => "git://github.com/bryanlarsen/vlad-git.git", :require => false
end
