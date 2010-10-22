module EventCalendar
  class Engine < ::Rails::Engine
    engine_name :event_calendar
    config.asset_path = "/event_calendar%s"
    #config.action_view.javascript_expansions[:event_calendar] = %w()
    #config.gem 'formtastic'
    #config.gem 'RedCloth'
    #config.gem 'prarupa'
    #config.gem 'will_paginate', '~> 3.0.pre2'
    #config.gem 'acts_as_revisable', '>= 1.1.2'
  end
  
  mattr_reader :app_type
  @@app_type = EventCalendar::Engine
end
