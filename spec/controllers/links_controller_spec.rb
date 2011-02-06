require 'spec_helper'

describe LinksController do
  subject{ Event }
  let(:link) do
    stub_model(Link)
  end
  let(:event) do
    mock_model(Event, {
      :save! => nil,
      :links => mock('Relation', {
        :build => link
      })
    })
  end
  before(:each) do
    subject.stub(:find).and_return(event)
  end
  describe "POST :create, :event_id => int, :link => {}" do
    let(:params) do
      {:event_id => event.id}
    end
    let(:link_params) do
      {:name => 'Created', :url => 'http://test.com'}
    end
    it "loads an @event" do
      post :create, params
      assigns(:event).should eq event
    end
    it "builds a new link" do
      event.links.should_receive(:build).with(link_params.stringify_keys)
      post :create, params.merge!({:link => link_params})
    end
    it "saves! the @event" do
      event.should_receive(:save!)
      post :create, params
    end
    it "renders events/show if an ActiveRecord::RecordInvalid exception is raised" do
      event.stub(:save!){ raise ActiveRecord::RecordInvalid.new(event) }
      post :create, params
      response.should render_template('events/show')
    end
    it "sets a flash[:notice]" do
      post :create, params
      flash[:notice].should_not be_nil
    end
    it "redirects to the event" do
      post :create, params
      response.should redirect_to event_path(event)
    end
  end
end
