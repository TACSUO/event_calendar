module EventCalendar::ApplicationHelper
  def link_wrapper(path, wrapper_options={}, link_options={})
    tag       = wrapper_options.delete(:tag) || :p
    link_text = link_options.delete(:link_text) || path
    highlight = wrapper_options.delete(:highlight)
  
    unless path.blank?
      if current_page?(path) && (highlight.nil? || highlight)
        wrapper_options = {:class => (wrapper_options[:class] || '') + " nav_highlight"}
      end
    end
  
    content_tag(tag, wrapper_options) do
      link_to(link_text, path, link_options)
    end
  end

  def link_to_new_event
    link_wrapper(event_calendar.new_event_path, {}, {
      :link_text => "Create New Event"
    })
  end

  def link_to_deleted_events
    link_wrapper(event_calendar.event_revisions_path, {}, {
      :link_text => "Restore Deleted Events (#{EventRevision.deleted.count})"
    })
  end

  def link_to_add_event_attendees(event)
    link_wrapper(event_calendar.new_event_attendee_path(event), {}, {
      :link_text => "Add <em>#{event.name}</em> Attendees".html_safe
    })
  end

  def link_to_edit_event(event)
    link_wrapper(event_calendar.edit_event_path(event), {}, {
      :link_text => "Edit <em>#{event.name}</em>".html_safe
    })
  end

  def link_to_delete_event(event)
    link_wrapper(event_calendar.event_path(event), {
      :highlight => false
    }, {
      :link_text => "Delete <em>#{event.name}</em>".html_safe,
      :confirm => 'Are you sure you want to permanently delete this event?',
      :method => "delete"
    })
  end

  def form_for_browse_event_revisions(event)
    render :partial => 'events/browse_event_revisions', :locals => {
      :event => event
    }
  end

  def render_event_navigation(event=nil)
    render :partial => 'event-calendar-shared/navigation', :locals => {
      :event => event
    }
  end

  def render_event_main_menu
    render :partial => 'event-calendar-shared/main_menu'
  end

  def render_flash
    render :partial => 'event-calendar-shared/flash', :object => flash
  end
end
