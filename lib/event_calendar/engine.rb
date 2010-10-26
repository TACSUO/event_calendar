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
      require 'action_view/template'
      class ActionView::Template
        def render_with_identifier_collection(view, locals, &block)
          (Thread.current[:view_identifiers] ||= []).push identifier
          render_without_identifier_collection(view, locals, &block)
        ensure
          Thread.current[:view_identifiers].pop
        end

        unless instance_methods.include? "render_without_identifier_collection"
          alias_method_chain :render, :identifier_collection
        end
      end
    end

    def engine_view?(identifier)
      @engine_views ||= Hash.new do |h, identifier|
        h[identifier] = !Rails.application.paths.app.views.any? do |path|
          identifier =~ /^#{Regexp.escape(path)}/
        end
      end
      @engine_views[identifier]
    end

    initializer "event_calendar.asset_path" do
      EventCalendar::ApplicationController.config.asset_path = lambda do |source|
        view_identifier = (Thread.current[:view_identifiers] ||= []).last
        engine_view?(view_identifier) ? "/#{ASSET_PREFIX}#{source}" : source
      end
    end
  end
end
