require 'spec_helper'

describe AttendeesController do
  describe ":index, :event_id => required" do
    before(:each) do
      Event.stub(:find).and_return(mock_event)
      class FakeModel
        extend ActiveModel::Naming
        def self.find(*args)
          new
        end
      end
      @fake_model = mock_model('FakeModel')
      Participant.stub(:types).and_return([FakeModel])
      Event.stub_chain(:includes, :find).and_return(mock_event)
    end
    
    it "loads an @event" do
      get :index, :event_id => "1"
      assigns[:event].should eql mock_event
    end
    it "renders the attendees template" do
      get :index, :event_id => "1"
      response.should render_template("attendees/index")
    end
  end
end
