require "event_calendar"
require "rails"

module EventCalendar
  class Engine < Rails::Engine
    ASSET_PREFIX = "event_calendar"
    ENGINEER_VERSION = "0.2.3"

    initializer "event_calendar.require_dependencies" do
      require 'bundler'
      gemfile = Bundler::Definition.build(root.join('Gemfile'), root.join('Gemfile.lock'), {})
      specs = gemfile.dependencies.select do |d|
        d.name != 'engineer' and (d.groups & [:default, :production]).any?
      end

      specs.collect { |s| s.autorequire || [s.name] }.flatten.each do |r|
        require r
      end
    end

    initializer "event_calendar.action_view.identifier_collection" do
      require 'event_calendar/action_view'
    end

    initializer "event_calendar.asset_path" do
      require 'event_calendar/asset_path'
      setup_asset_path
    end
  end
end
