class EventCalendarController < EventCalendar::ApplicationController
  
  helper_method :engine_path
  
  private
    def registered_engines
      Rails::Engine.subclasses.map do |sc|
        sc.to_s.underscore.gsub("/engine", "")
      end << 'main_app'
    end
    def engine_path(obj_or_class, options={})
      class_name = obj_or_class.kind_of?(Class) ? obj_or_class.to_s : obj_or_class.class.to_s
      
      @cached_engine_classes ||= {}
      
      return_path = ''
      if @cached_engine_classes[class_name]
        return_path = send(@cached_engine_classes[class_name]).polymorphic_path(obj_or_class, options)
      end
      
      count = 0
      while return_path.blank? do
        begin
          if registered_engines[count].blank?
            return_path = "/"
          else
            return_path = send(registered_engines[count]).polymorphic_path(obj_or_class, options)
            
            @cached_engine_classes[class_name] = registered_engines[count]
          end
        rescue NoMethodError => e
          logger.debug(e.message)
          count += 1
          retry
        end
      end
      return_path
    end
  protected
  public
end