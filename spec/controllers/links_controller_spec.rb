require 'spec_helper'

describe LinksController do
  subject{ Event }
  let(:stub_link) do
    stub_model(Link)
  end
  let(:link) do
    mock_model(Link)
  end
  let(:event) do
    mock_model(Event, {
      :save! => nil,
      :links => mock('Relation', {
        :build => stub_link
      })
    })
  end
  before(:each) do
    subject.stub(:find).and_return(event)
  end
  describe "GET :edit, :event_id => int, :id => int" do
    let(:params) do
      {:event_id => event.id, :id => link.id}
    end
    before(:each) do      
      Link.should_receive(:find){ link }
    end
    it "loads an @event and @link" do
      get :edit, params
      assigns(:event).should eq event
      assigns(:link).should eq link
    end
    it "renders the edit template" do
      get :edit, params
      response.should render_template('links/edit')
    end
  end
  describe "PUT :update, :event_id => int, :id => int, :link => {}" do
    let(:params) do
      {:event_id => event.id, :id => link.id}
    end
    let(:link_params) do
      {:name => 'Updated', :url => 'example.com/updated.html'}
    end
    before(:each) do
      link.stub(:update_attributes){ nil }
      Link.should_receive(:find){ link }
    end
    it "loads an @event and @link" do
      put :update, params
      assigns(:event).should eq event
      assigns(:link).should eq link
    end
    it "updates the @link" do
      link.should_receive(:update_attributes).with(link_params.stringify_keys)
      put :update, params.merge!({:link => link_params})
    end
    context "update succeeds :)" do
      before(:each) do
        link.stub(:update_attributes){ true }
      end
      it "sets flash[:notice]" do
        put :update, params
        flash[:notice].should_not be_nil
      end
      it "redirects to @event" do
        put :update, params
        response.should redirect_to event_path(event)
      end
    end
    context "update fails :(" do
      before(:each) do
        link.stub(:update_attributes){ false }
      end
      it "renders the edit template" do
        put :update, params
        response.should render_template('links/edit')
      end
    end
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
  describe "DELETE :destroy, :event_id => int, :id => int" do
    let(:params) do
      {:event_id => event.id, :id => link.id}
    end
    before(:each) do
      link.stub(:destroy){ nil }
      Link.should_receive(:find){ link }
    end
    it "destroys a link" do
      link.should_receive(:destroy)
      delete :destroy, params
    end
    it "redirects to :event_id" do
      delete :destroy, params
      response.should redirect_to event_path event.id
    end
  end
end
