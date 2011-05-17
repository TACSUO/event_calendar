# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

EventCalendar::Application.load_tasks

excluded_files = %w(config/database.yml)

Jeweler::Tasks.new do |gem|
  gem.name = "event_calendar_engine"
  gem.summary = %Q{Simple versioned event management for Rails 3.}
  gem.description = %Q{Provides basic event management features with versioned history of changes.}
  gem.email = ["jason.lapier@gmail.com", "jeremiah@inertialbit.net"]
  gem.homepage = "http://github.com/inertialbit/event_calendar"
  gem.authors = ["Jason LaPier", "Jeremiah Heller"]
  gem.require_path = 'lib'
  gem.files =  FileList[
    "[A-Z]*",
    "{app,config,lib,public,vendor}/**/*",
    "db/**/*.rb"
  ]
  gem.test_files = FileList["spec/**/*"]
  excluded_files.each{|f| gem.files.exclude(f)}

  gem.add_dependency 'rails', '~> 3.0.7'
  gem.add_dependency 'RedCloth'
  gem.add_dependency 'prarupa'
  gem.add_dependency 'formtastic'
  gem.add_dependency 'acts_as_revisable'
  gem.add_dependency 'will_paginate', '~> 3.0.pre2'
  
  gem.add_development_dependency 'jeweler'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'cucumber-rails'
  gem.add_development_dependency 'capybara'
  gem.add_development_dependency 'acts_as_fu'
  gem.add_development_dependency 'rcov'
  gem.add_development_dependency 'sqlite3'

  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
end
