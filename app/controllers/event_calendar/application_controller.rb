class EventCalendar::ApplicationController < defined?(ApplicationController) ? ApplicationController : ActionController::Base
  protect_from_forgery

  prepend_before_filter :use_engine_assets if Rails.env != 'production'
  prepend_before_filter :setup_asset_path if defined?(EventCalendar::Engine)
  
  private
    def use_engine_assets
      require 'event_calendar/action_view'
    end
    def setup_asset_path
      config.asset_path = '/event_calendar%s'
    end
  protected
  public
end
