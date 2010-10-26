module EventCalendar
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def self.source_root
        @source_root ||= File.expand_path('../templates', __FILE__)
      end

      def install_rake_tasks
        directory '.', File.join("lib", "tasks")
      end

      def rake_engine_install
        rake "event_calendar:install"
      end

    end
  end
end
