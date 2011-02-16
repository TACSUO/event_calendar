module EventCalendar
  class Engine < Rails::Engine
    ASSET_PREFIX = "event_calendar"

    initializer "event_calendar.asset_path" do |app|
      app.config.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
  end
end
