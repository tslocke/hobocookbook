source 'http://rubygems.org'

gem 'rails', '3.1.4'
gem 'rake', '0.8.7'
gem 'will_paginate', '~> 3.0.0'

gem 'sqlite3'
gem 'mysql'

gem 'yard'

group :development do
  # set to 0.43 due to problem with .45 see https://github.com/rails/rails/pull/1671
  gem 'ruby-debug19'
  gem 'rails-dev-tweaks'
end

gem "maruku"

#temp workaround for hash_secret issue see https://groups.google.com/forum/#!topic/hobousers/dS4VT_lyVIY
#gem "paperclip", "~> 2.3"
gem 'paperclip', :git => "git://github.com/jeanmartin/paperclip.git", :branch => "master"
#required by paperclip
gem "cocaine"

gem "hobo_support", :path => "/work/hobo/hobo_support"
gem "hobo_fields", :path => "/work/hobo/hobo_fields"
gem "dryml", :path => "/work/hobo/dryml"
gem "hobo", :path => "/work/hobo/hobo"
gem "hobo_rapid", :path => "/work/hobo/hobo_rapid"
gem "hobo_clean", :path => "/work/hobo/hobo_clean"
gem "hobo_jquery", :path => "/work/hobo/hobo_jquery"

gem "jquery-rails"
gem "jquery-ui-themes"

group :development do
  gem "vlad", :require => false
  gem "vlad-git", :git => "git://github.com/bryanlarsen/vlad-git.git", :require => false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end
