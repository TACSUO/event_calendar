module EventCalendar::ApplicationHelper
  def div_for_record(record, options={}, &block)
    div_for(record, options){ yield }
  end
  def tag_for_record(tag, record, *args, &block)
    content_tag_for(tag, record, *args){ yield }
  end
  
  def link_wrapper(path, wrapper_options={}, link_options={})
    tag       = wrapper_options.delete(:tag) || :p
    link_text = link_options.delete(:link_text) || path
    highlight = wrapper_options.delete(:highlight)
  
    unless path.blank?
      if current_page?(path) && (highlight.nil? || highlight)
        wrapper_options.merge!({
          :class => (wrapper_options[:class] || '') + " nav_highlight"
        })
      end
    end
  
    unless wrapper_options.delete(:no_wrapper)
      return content_tag(tag, wrapper_options) do
        link_to(link_text, path, link_options)
      end
    else
      return link_to(link_text, path, link_options)
    end
  end
  
  def time_with_zones(time=Time.now)
    out = []
    ActiveSupport::TimeZone.us_zones.map(&:name).each do |us_zone|
      next unless us_zone =~ /Pacific|Mountain|Central|Eastern/
      key = time.in_time_zone(us_zone).strftime("%Z")
      key = timezone_in_words(key.strip)
      # out[key] = time.in_time_zone(us_zone).strftime(format)
      out << [key, time.in_time_zone(us_zone).strftime(TIME_BASE)]
    end
    out.reverse
  end
      
  def timezone_in_words(zone)
    pac_regex = /^P(S|D)T$/
    mnt_regex = /^M(S|D)T$/
    ctr_regex = /^C(S|D)T$/
    est_regex = /^E(S|D)T$/
    case zone
    when pac_regex
      zone.gsub(pac_regex, 'Pacific')
    when mnt_regex
      zone.gsub(mnt_regex, 'Mountain')
    when ctr_regex
      zone.gsub(ctr_regex, 'Central')
    when est_regex
      zone.gsub(est_regex, 'Eastern')
    else
      zone
    end
  end
  
  def times_with_zones(event)
    [
      time_with_zones(event.start_time),
      time_with_zones(event.end_time)
    ]
  end
  
  def link_to_events(wrapper_options={}, link_options={})
    return unless has_authorization?(:read, Event.new)
    link_wrapper(events_path, wrapper_options, link_options.reverse_merge!({
      :link_text => 'Event Calendar'
    }))
  end
  
  def link_to_event_revisions(wrapper_options={}, link_options={})
    return unless has_authorization?(:read, EventRevision.new)
    link_wrapper(event_revisions_path, {
      :no_wrapper => true
    }.merge!(wrapper_options), {
      :link_text => 'Browse Event Revisions'
    }.merge!(link_options))
  end

  def link_to_new_event(wrapper_options={}, link_options={})
    return unless has_authorization?(:create, Event.new)
    link_wrapper(new_event_path, {
      :no_wrapper => true
    }.merge!(wrapper_options), {
      :link_text => "Create New Event"
    }.merge!(link_options))
  end

  def link_to_deleted_events(wrapper_options={})
    return unless has_authorization?(:update, Event.new)
    link_wrapper(event_revisions_path, wrapper_options, {
      :link_text => "Browse Deleted Events (#{EventRevision.deleted.count})"
    })
  end

  def link_to_add_event_attendees(event, wrapper_options={})
    return unless has_authorization?(:add_attendees, event)
    link_wrapper(new_event_attendee_path(event), wrapper_options, {
      :link_text => "Add <em>#{h(event.name)}</em> Attendees".html_safe
    })
  end

  def link_to_edit_event(event, wrapper_options={}, link_options={})
    return unless has_authorization?(:update, event)
    link_wrapper(edit_event_path(event), wrapper_options, {
      :link_text => "Edit <em>#{h(event.name)}</em>".html_safe
    }.merge!(link_options))
  end

  def link_to_delete_event(event, wrapper_options={}, link_options={})
    return unless has_authorization?(:delete, event)
    link_wrapper(event_path(event), {
      :highlight => false
    }.merge!(wrapper_options), {
      :link_text => "Delete <em>#{event.name}</em>".html_safe,
      :confirm => "Are you sure you want to permanently delete the #{event.name} #{event.event_type}?",
      :method => "delete"
    }.merge!(link_options))
  end
  
  def links_to_edit_and_delete_event(event, wrapper_options={}, link_options={})
    return unless has_authorization?(:delete, event) || has_authorization?(:update, event)
    link_to_edit_event(event, {
      :no_wrapper => true
    }.merge!(wrapper_options), {
      :link_text => 'edit'
    }.merge!(link_options)) + " " +
    link_to_delete_event(event, {
      :no_wrapper => true
    }.merge!(wrapper_options), {
      :link_text => 'delete'
    }.merge!(link_options))
  end

  def form_for_browse_event_revisions(event)
    return unless has_authorization?(:update, event)
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
  
  def event_calendar_asset_prefix
    'event_calendar/'
  end
  
  def event_calendar_javascript_includes
    list = [
      "#{event_calendar_asset_prefix}jquery.tablesorter.min.js",
      "#{event_calendar_asset_prefix}jquery-ui-1.7.2.custom.min.js",
      "#{event_calendar_asset_prefix}jquery.string.1.0-min.js",
      "#{event_calendar_asset_prefix}jquery.clonePosition.js",
      "#{event_calendar_asset_prefix}lowpro.jquery.js",
      "#{event_calendar_asset_prefix}fullcalendar.js",
      "#{event_calendar_asset_prefix}jquery.qtip-1.0.0-rc3.js",
      "#{event_calendar_asset_prefix}rails",
      "#{event_calendar_asset_prefix}event_calendar_behaviors.js",
      "#{event_calendar_asset_prefix}event_calendar.js"
    ]
    unless Rails.env == 'production'
      list.unshift("#{event_calendar_asset_prefix}jquery")
    else
      list.unshift("http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js")
    end
  end
end
