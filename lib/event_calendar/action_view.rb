module EventCalendar  
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