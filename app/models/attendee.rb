class Attendee < ActiveRecord::Base  
  belongs_to :event
  belongs_to :particpant, :polymorphic => true
end