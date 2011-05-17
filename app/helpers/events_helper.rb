module EventsHelper
  def event_one_liner(event)
    [
      h(event.name),
      event_abbrev_date(event),
      event_type_label(event.event_type),
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
  
  def event_type_label(event_type)
    "<span class=\"category_label #{event_type_css_class(event_type)}\">#{h(event_type)}</span>".html_safe
  end
  
  def event_type_css_class(event_type)
    css_class = event_type.parameterize('_').downcase
    h("#{css_class}_event")
  end
  
  def event_type_legend(wrapper_css_class, wrapper_css_style='')
    return '' unless @event_types.any?
    
    content_tag :ul, :class => "#{wrapper_css_class} legend", :style => wrapper_css_style do
      @event_types.map do |event_type|
        css_class = event_type_css_class(event_type)
        content_tag :li, :class => "#{css_class} category_label" do
          link_to h(event_type), events_path(:event_type => event_type)
        end
      end.join("\n").html_safe
    end
  end
end