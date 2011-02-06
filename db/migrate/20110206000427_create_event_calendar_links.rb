class CreateEventCalendarLinks < ActiveRecord::Migration
  def self.up
    create_table :event_calendar_links do |t|
      t.string :name
      t.string :url
      
      t.timestamps
    end
    
    create_table :event_calendar_events_links, :id => false do |t|
      t.integer :event_id
      t.integer :link_id
    end
    
    add_index :event_calendar_events_links, [:event_id, :link_id]
  end

  def self.down
    drop_table :event_calendar_links
  end
end
