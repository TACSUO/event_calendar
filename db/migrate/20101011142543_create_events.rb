class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :event_calendar_events do |t|
      t.string :name
      t.string :event_type
      t.date :start_on
      t.date :end_on
      t.text :location
      t.text :description
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :event_calendar_events
  end
end
