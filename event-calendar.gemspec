# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'event-calendar/version'
 
Gem::Specification.new do |s|
  s.name = "event-calendar"
  s.summary = "Simple versioned event management for Rails 3."
  s.homepage = "http://github.com/inertialbit/event-calendar"
  s.description = "Provides basic event management features with versioned history of changes.

  Can be run either as an Engine or standalone Rails app.

  Use as Engine

  - Setup integration app with edge rails
  - Build & Install event-calendar gem
  - Update integration app's Gemfile to use the event-calendar gem
  - Copy migrations & Create symlinks to public
  - Setup database and run migrations

  Rake tasks provided by edge rails:

    FROM=event_calendar rake railties:copy_migrations
    rake railties:create_symlinks"
  s.version = EventCalendar::Version.number
  s.platform = Gem::Platform::RUBY
  s.authors = ["Jason LaPier", "Jeremiah Heller"]
  s.email = ["jason.lapier@gmail.com", "jeremiah@inertialbit.net"]
  s.summary = "Rails 3 Event Calendar Engine"
  s.files = Dir["Gemfile", "{vendor}/**/*", "{lib}/**/*", "{app}/**/*", "{config}/**/*", "{db}/migrate/**/*", "{db}/seeds.rb", "{public}/images/**/*", "{public}/stylesheets/**/*", "{public}/javascripts/**/*", "{public}/event_calendar/**/*"]
  s.required_rubygems_version = ">= 1.3.7"

  s.add_dependency('rails', '>= 3.0.0')
  s.add_dependency('sqlite3-ruby')
  s.add_dependency('will_paginate', '~> 3.0.pre2')
  s.add_dependency('formtastic')
  s.add_dependency('acts_as_revisable', '>= 1.1.2')
  s.add_dependency('RedCloth')
  s.add_dependency('prarupa')
  
  
  s.add_development_dependency('rspec-rails', '>= 2.0.0.beta.22')
  s.add_development_dependency('cucumber-rails')
  s.add_development_dependency('capybara')
  s.add_development_dependency('acts_as_fu')
end