class Event < ActiveRecord::Base
  set_table_name "event_calendar_events"
  
  include ActionView::Helpers::TextHelper
  
  include EventInstanceMethods

  has_many :attendees

  validates_presence_of :name, :event_type, :start_on
  
  searchable_by :name, :event_type, :location, :description
  
  acts_as_revisable :revision_class_name => 'EventRevision', :on_delete => :revise
  
  scope :past, where(sanitize_sql_array(["end_on < '%s'", Date.current]))
  scope :future, where(sanitize_sql_array(["start_on > '%s'", Date.current]))
  scope :current, where(sanitize_sql_array(["end_on >= '%s'", Date.current]))
  scope :between, lambda{ |start_datetime, end_datetime|
    where(["start_on BETWEEN ? AND ? OR end_on BETWEEN ? AND ?",
      start_datetime, end_datetime, start_datetime, end_datetime])
  }
  
  validate :sane_dates
  
  before_validation do
    if end_on.in_time_zone(timezone).hour == 06
      self.end_on = Time.local(nil, start_on.min, start_on.in_time_zone(timezone).hour + 1, start_on.in_time_zone(timezone).day, start_on.in_time_zone(timezone).month, start_on.in_time_zone(timezone).year, nil, nil, nil, timezone)
    end
  end
  #before_save :set_timezone

  private

    def sane_dates
      if start_on and end_on and start_on > end_on
        errors.add :end_on, "calculated as #{end_on.in_time_zone(timezone).strftime('%A, %B %d %Y @ %I:%m%p')} but cannot be before the start date #{start_on.in_time_zone(timezone).strftime('%A, %B %d %Y @ %I:%m%p')}"# "cannot be before the start date"
      end
    end
    
    def set_timezone
      Time.zone = timezone
    end
  protected
  public  
    
    def self.existing_event_types
      select('DISTINCT event_type').map(&:event_type).reject { |ev| ev.blank? }.sort
    end
    
    def participants
      return [] if attendees.count == 0
      attendees.all.collect do |attendee|
        attendee.participant
      end
    end

    def to_s
      "#{name} (#{start_on} #{end_on ? ' - ' + end_on.to_s : ''})"
    end
end
