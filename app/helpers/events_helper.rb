module EventsHelper
  def event_one_liner(event)
    [
      h(event.name),
      event_abbrev_date(event),
      event_type_label(event),
      event_details_link(event)
    ].
    join(" ").html_safe
  end
  
  def event_abbrev_date(event)
    if event.one_day?
      "(<em>#{event.start_on.strftime("%a")} #{event.start_day.ordinalize}</em>)".html_safe
    else
      "(<em>#{event.start_on.strftime("%a")} #{event.start_day.ordinalize} - #{event.end_on.strftime("%a")} #{event.end_day.ordinalize}</em>)".html_safe
    end
  end
  
  def event_details_link(event)
    path = event.deleted? ? 'event_revision_path' : 'event_path'
    "<span class=\"fake_button\">#{link_to('Details', send(path, event))}</span>".html_safe
  end
  
  def event_type_label(event)
    event_type_css_class = event.event_type.parameterize('_').downcase +
                           "_category_label"
    "<span class=\"category_label #{h(event_type_css_class)}\">#{h(event.event_type)}</span>".html_safe
  end
end