class MakeEventsRevisable < ActiveRecord::Migration
  def self.up
    add_column :event_calendar_events, :revisable_original_id, :integer
    add_column :event_calendar_events, :revisable_branched_from_id, :integer
    add_column :event_calendar_events, :revisable_number, :integer, :default => 0
    add_column :event_calendar_events, :revisable_name, :string
    add_column :event_calendar_events, :revisable_type, :string
    add_column :event_calendar_events, :revisable_current_at, :datetime
    add_column :event_calendar_events, :revisable_revised_at, :datetime
    add_column :event_calendar_events, :revisable_deleted_at, :datetime
    add_column :event_calendar_events, :revisable_is_current, :boolean, :default => true
  end

  def self.down
    remove_column :event_calendar_events, :revisable_original_id
    remove_column :event_calendar_events, :revisable_branched_from_id
    remove_column :event_calendar_events, :revisable_number
    remove_column :event_calendar_events, :revisable_name
    remove_column :event_calendar_events, :revisable_type
    remove_column :event_calendar_events, :revisable_current_at
    remove_column :event_calendar_events, :revisable_revised_at
    remove_column :event_calendar_events, :revisable_deleted_at
    remove_column :event_calendar_events, :revisable_is_current
  end
end
