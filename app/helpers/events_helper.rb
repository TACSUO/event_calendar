module EventsHelper
  def event_one_liner(event)
    path = event.deleted? ? 'event_revision_path' : 'event_path'
    "#{h(event.name)} #{event_abbrev_date(event)} <span class=\"fake_button\">#{link_to('details', send(path, event))}</span>".html_safe
  end
  
  def event_abbrev_date(event)
    if event.one_day?
      "(<em>#{event.start_on.strftime("%a")} #{event.start_day.ordinalize}</em>)"
    else
      "(<em>#{event.start_on.strftime("%a")} #{event.start_day.ordinalize} - #{event.end_on.strftime("%a")} #{event.end_day.ordinalize}</em>)"
    end
  end
end