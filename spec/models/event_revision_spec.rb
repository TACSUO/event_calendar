require 'spec_helper'

describe EventRevision do
  
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :event_type => "Meeting",
      :start_on => Date.today,
      :end_on => Date.today,
      :location => "value for location",
      :description => "value for description"
    }
    @event = Event.create!(@valid_attributes)
    @event.name = 'other value'
    @event.save
    @event_revision = @event.find_revision(:previous)
    
    # pending
    #@contact = mock_model(Contact)
    #Contact.stub(:find).and_return([@contact])
  end
  
  it "should have an attendee collection" do
    pending
    @event_revision.attendees.count.should == 0
  end
  
  it "should instantiate Contacts as attendees" do
    pending
    Contact.should_receive(:find).and_return([@contact])
    @event_revision.attendee_roster = "#{@contact.id}"
    @event_revision.attendees.should == [@contact]
  end  
  
end