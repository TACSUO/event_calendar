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
    @may_2010 = Event.create!(@valid_attributes)
    @mar_2100 = Event.create!(@valid_attributes.merge!({
      :start_on => (365 * 24 * 5).hours.from_now,
      :end_on => ((365 * 24 * 5) + 72).hours.from_now
    }))
    @current = Event.create!(@valid_attributes.merge!({
      :start_on => 72.hours.ago,
      :end_on => 48.hours.from_now
    }))
  end
  
  it "Event.past finds past events" do
    Event.past.first.should eql @may_2010
  end
  
  it "Event.future finds future events" do
    Event.future.first.should eql @mar_2100
  end
  
  it "Event.current finds current events (in progress and future)" do
    Event.current.should include @current
    Event.current.should include @mar_2100
  end
  
  it "Event.between finds events between limits" do
    Event.between((362 * 24 * 5).hours.from_now, ((365 * 24 * 5) + 72).hours.from_now).first.should eql @mar_2100
  end

  it "should create a new instance given valid attributes" do
    Event.create!(@valid_attributes)
  end
  
  it "must start before it can end" do
    event = Event.new(@valid_attributes)
    event.end_on = 6.months.ago
    event.should_not be_valid
  end
  
  it "sets end_on to start_on.hour + 1 before_validation if end_on.hour == 6am" do
    Time.zone = 'UTC'
    event = Event.new(@valid_attributes.merge!({
      :timezone => 'Pacific Time (US & Canada)',
      :start_on => Time.utc(Date.current.year, Date.current.month, Date.current.day, 8, 0),
      :end_on => Time.utc(Date.current.year, Date.current.month, Date.current.day, 6, 0)
    }))
    event.valid?
    event.end_on.should eq event.start_on + 1.hour
  end

  it "should find event types" do
    Event.create!(@valid_attributes)
    Event.create!(@valid_attributes.merge :event_type => 'Conference')
    Event.existing_event_types.should == ['Conference', 'Meeting']
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
  
end
