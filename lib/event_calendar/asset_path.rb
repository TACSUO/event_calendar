module EventCalendar
  class Engine < Rails::Engine
    def engine_view?(identifier)
      @engine_views ||= Hash.new do |h, identifier|
        h[identifier] = !Rails.application.paths.app.views.any? do |path|
          identifier =~ /^#{Regexp.escape(path)}/
        end
      end
      @engine_views[identifier]
    end
    def setup_asset_path
      EventCalendar::ApplicationController.config.asset_path = lambda do |source|
        view_identifier = (Thread.current[:view_identifiers] ||= []).last
        engine_view?(view_identifier) ? "/#{ASSET_PREFIX}#{source}" : source
      end
    end
  end
end