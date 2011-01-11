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
  scope :current, where(sanitize_sql_array(["end_on >= '%s' AND start_on <= '%s'", Date.current, Date.current]))
  scope :between, lambda{ |start_datetime, end_datetime|
    where(["start_on BETWEEN ? AND ? OR end_on BETWEEN ? AND ?",
      start_datetime, end_datetime, start_datetime, end_datetime])
  }
  
  validate :sane_dates
  
  before_save :set_timezone

  private

    def sane_dates
      if start_on and end_on and start_on > end_on
        errors.add :end_on, "cannot be before the start date"
      end
    end
    
    def set_timezone
      Time.zone = timezone
    end
    
  protected
  public  
    def participants
      return [] if attendees.count == 0
      attendees.all.collect do |attendee|
        attendee.participant
      end
    end

    def self.existing_event_types
      select('DISTINCT event_type').map(&:event_type).reject { |ev| ev.blank? }.sort
    end
    
    # def update_roster
    #   self.attendee_roster = attendees.collect{|a| a.contact_id}.join(',')
    # end

    # def drop_attendees(drop_contact_ids)
    #   drop_contact_ids = [*drop_contact_ids].compact.map(&:to_i)
    #   changeset! do |event|
    #     event.attendees.find(:all, {
    #       :select => 'id',
    #       :conditions => ["contact_id IN (?)", drop_contact_ids]
    #     }).each{|a| a.destroy && !a.destroyed?}
    #     event.update_roster
    #     event.save
    #   end
    # end
    
    # def add_attendees(from_contact_ids)
    #   changeset! do |event|
    #     from_contact_ids.each do |c_id|
    #       event.attendees.build(:contact_id => c_id)
    #     end
    #     event.update_roster
    #     event.save
    #   end
    # end

    def to_s
      "#{name} (#{start_on} #{end_on ? ' - ' + end_on.to_s : ''})"
    end

    # list all groups that had least one member in attendance at this event
    # def contact_groups_represented
    #   @contact_groups_represented ||= contacts.map(&:contact_groups).flatten.uniq
    # end
    
    # def name_and_file_count
    #   "#{name} (#{pluralize(file_attachments.count, 'file')})"
    # end
end
