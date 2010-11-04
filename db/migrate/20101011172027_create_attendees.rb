class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :event_calendar_attendees do |t|
      t.integer :event_id
      t.integer :participant_id
      t.string :participant_type
      t.string :role
      
      t.timestamps
    end
  end

  def self.down
    drop_table :event_calendar_attendees
  end
end
