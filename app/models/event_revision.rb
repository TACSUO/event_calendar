class EventRevision < ActiveRecord::Base
  acts_as_revision :revisable_class_name => 'Event'
end