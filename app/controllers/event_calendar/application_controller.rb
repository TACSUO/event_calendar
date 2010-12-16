class EventCalendar::ApplicationController < ApplicationController
  helper_method :has_authorization?
  
  private
  unless private_method_defined?(:has_authorization?)
    def has_authorization?(*args)
      true
    end
  end
  protected
  public
end
