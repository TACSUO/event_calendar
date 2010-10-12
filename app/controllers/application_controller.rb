class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :event_calendar
  
  private
    def event_calendar
      if defined?(EventCalendar::Engine)
        super
      else
        return self
      end
    end
  protected
  public
end
