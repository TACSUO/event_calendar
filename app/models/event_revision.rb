class EventRevision < ActiveRecord::Base
  acts_as_revision :revisable_class_name => 'Event'
  
  include DeletableInstanceMethods
  
  scope :deleted, where("revisable_deleted_at IS NOT NULL")
end