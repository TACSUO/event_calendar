module EventsHelper
  def event_one_liner(event)
    "#{h(event.name)} #{event_abbrev_date(event)} #{event_details_link(event)}".html_safe
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
    "<span class=\"fake_button\">#{link_to('details', send(path, event))}</span>".html_safe
  end
end