require 'spec_helper'

describe Event do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :event_type => "Meeting",
      :start_on => Date.new(2010,5,5),
      :end_on => Date.new(2010,5,6),
      :location => "value for location",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Event.create!(@valid_attributes)
  end
  
  it "must start before it can end" do
    event = Event.new(@valid_attributes)
    event.end_on = Date.new(2010,5,3)
    event.should_not be_valid
  end

  it "should find event types" do
    Event.create!(@valid_attributes)
    Event.create!(@valid_attributes.merge :event_type => 'Conference')
    Event.existing_event_types.should == ['Conference', 'Meeting']
  end
  
  it "should call to_hash_for_calendar" do
    event = Event.create! :name => "test", :start_on => "2010-01-01", :end_on => "2010-01-07", 
      :event_type => "meeting", :description => "some kind of meeting", :location => 'skype.address'
    event.to_hash_for_calendar("/events/#{event.id}").should == { :id => event.id, :title => "test", 
      :start => Date.new(2010,1,1), :end => Date.new(2010,1,7), :url => "/events/#{event.id}",
      :description => "some kind of meeting", :location => 'skype.address' }
  end
  
  it "should create a new version when an attribute is updated" do
    event = Event.create!(@valid_attributes)
    event.revision_number.should == 0
    event.name = "updated test"
    event.save
    event.revision_number.should == 1
  end
  
  it "should create a new version when using update_attributes" do
    event = Event.create!(@valid_attributes)
    event.revision_number.should == 0
    event.update_attributes(:name => "updated test")
    event.revision_number.should == 1
  end
  
  it "should not create a new version when no attributes have changed" do
    event = Event.create!(@valid_attributes)
    event.revision_number.should == 0
    event.name = @valid_attributes[:name]
    event.save
    event.revision_number.should == 0
  end
  
  context "with attendees" do
    
    before(:each) do
      @event = Event.create!(@valid_attributes)
      # pending
      #@contact = mock_model(Contact)
      #@event.add_attendees([@contact.id])
      #@event.save
      #Contact.stub(:find).and_return([@contact])
    end

    context "adding an attendee" do
      
      it "should update attendee_roster" do
        pending
        @event.attendee_roster.should == @contact.id.to_s
      end

      it "should create a new version" do
        pending
        @event.revision_number.should == 1
      end

      it "should have previous set of attendees available through the previous revision" do
        pending
        @event.find_revision(:previous).attendees.count.should == 0
        @event.add_attendees([@contact.id])
        @event.find_revision(:previous).attendees.count.should == 1
        @event.attendees.count.should == 2
      end
    end

    context "removing an attendee" do

      before(:each) do
        # pending
        #@event.attendees.count.should == 1
        #@attendee = @event.attendees.first
        #@event.drop_attendees(@attendee.contact_id)
      end
      
      it "should not include the removed attendee in the current collection" do
        pending
        @event.attendees.count.should == 0
      end
      
      it "should create a new version" do
        pending
        @event.revision_number.should == 2
      end
      
      it "should have previous set of attendees available through the previous revision" do
        pending
        @event.find_revision(:previous).attendees.should == @attendee.contact
      end

    end
  end
  
end
