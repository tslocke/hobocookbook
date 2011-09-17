# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Hobocookbook::Application.load_tasks



require(File.join(File.dirname(__FILE__), 'config', 'boot'))

# from previous version

#require 'thread'
#require 'rake'
#require 'rake/testtask'
#require 'rake/rdoctask'
#
#require 'tasks/rails'
require 'vlad'
#require 'vlad-git'
Vlad.load(:app => nil, :scm => :git)
