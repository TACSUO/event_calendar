class Event < ActiveRecord::Base
  
  include ActionView::Helpers::TextHelper
  
  has_many :attendees
  #has_many :contacts, :through => :attendees, :order => ["last_name, first_name"],
  # :conditions => {:revisable_is_current => true}
  
  #has_many :file_attachments

  #belongs_to :modified_by_user, :class_name => 'User'

  validates_presence_of :name, :event_type, :start_on

  # acts_as_stripped :name
  
  searchable_by :name, :event_type, :location, :description
  
  acts_as_revisable :revision_class_name => 'EventRevision', :on_delete => :revise
  
  validate :sane_dates

  private

    def sane_dates
      if start_on and end_on and start_on > end_on
        errors.add :end_on, "cannot be before the start date"
      end
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
  
    def to_hash_for_calendar(url)
      # { :id => id, :title => name_and_file_count, :start => start_on, :end => end_on, :url => "/events/#{id}", 
      #   :description => description && description.gsub("\n", "<br/>") || '',
      #   :location => location && location.gsub("\n", "<br/>") || '' }
      { :id => id, :title => name, :start => start_on, :end => end_on, :url => url, 
        :description => description && description.gsub("\n", "<br/>") || '',
        :location => location && location.gsub("\n", "<br/>") || '' }
    end

    # list all groups that had least one member in attendance at this event
    # def contact_groups_represented
    #   @contact_groups_represented ||= contacts.map(&:contact_groups).flatten.uniq
    # end
    
    # def name_and_file_count
    #   "#{name} (#{pluralize(file_attachments.count, 'file')})"
    # end
end
