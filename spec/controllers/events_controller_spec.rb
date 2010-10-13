require 'spec_helper'

describe require 'spec_helper'

describe EventsController do

  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs)
  end

  # def mock_admin_user(stubs={})
  #   @mock_admin_user ||= mock_model(User, stubs.merge({
  #     :role => 'admin',
  #     :contact => mock_model(Contact, {
  #       :first_name => 'First',
  #       :last_name => 'Last',
  #       :email => 'test@test.com'
  #     })
  #   }))
  # end

  # def mock_user(stubs={})
  #   @mock_user ||= mock_model(User, stubs.merge({:role => 'general'}))
  # end

  describe "when logged in as admin" do
    before do
      # pending
      # controller.stub(:current_user_session).and_return(
      #   mock_model(UserSession, {
      #     :user => mock_admin_user
      #   })
      # )
    end

    describe "GET index" do
      it "assigns all events as @events" do
        Event.stub(:find).with(:all).and_return([mock_event])
        get :index
        assigns[:events].should == [mock_event]
      end
    end
    
    describe "GET index as json" do
      it "renders @events as json" do
        mock_event.stub(:to_hash_for_calendar).and_return( { :id => 1, :name => "whatever" } )
        Event.stub(:find).with(:all).and_return([mock_event])
        get :index, :format => 'js'
        response.should be_success
      end
    end

    describe "GET show" do
      it "assigns the requested event as @event" do
        Event.stub(:find).with("37").and_return(mock_event)
        get :show, :id => "37"
        assigns[:event].should equal(mock_event)
      end
    end

    describe "GET new" do
      it "assigns a new event as @event" do
        Event.stub(:new).and_return(mock_event)
        get :new
        assigns[:event].should equal(mock_event)
      end
    end

    describe "GET edit" do
      it "assigns the requested event as @event" do
        Event.stub(:find).with("37").and_return(mock_event)
        get :edit, :id => "37"
        assigns[:event].should equal(mock_event)
      end
    end

    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created event as @event" do
          Event.stub(:new).with({'these' => 'params'}).and_return(mock_event(:save => true, :modified_by_user= => nil))
          post :create, :event => {:these => 'params'}
          assigns[:event].should equal(mock_event)
        end

        it "redirects to the created event" do
          Event.stub(:new).and_return(mock_event(:save => true, :modified_by_user= => nil))
          post :create, :event => {}
          response.should redirect_to(event_url(mock_event))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved event as @event" do
          Event.stub(:new).with({'these' => 'params'}).and_return(mock_event(:save => false, :modified_by_user= => nil))
          post :create, :event => {:these => 'params'}
          assigns[:event].should equal(mock_event)
        end

        it "re-renders the 'new' template" do
          Event.stub(:new).and_return(mock_event(:save => false, :modified_by_user= => nil))
          post :create, :event => {}
          response.should render_template('new')
        end
      end

    end

    describe "PUT update" do

      describe "with valid params" do
        it "updates the requested event" do
          Event.should_receive(:find).with("37").and_return(mock_event)
          # mock_event.should_receive(:update_attributes).with({'these' => 'params',
          #   'modified_by_user' => mock_admin_user})
          
          mock_event.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :event => {:these => 'params'}
        end

        it "assigns the requested event as @event" do
          Event.stub(:find).and_return(mock_event(:update_attributes => true))
          put :update, :id => "1", :event => {}
          assigns[:event].should equal(mock_event)
        end

        it "redirects to the event" do
          Event.stub(:find).and_return(mock_event(:update_attributes => true))
          put :update, :id => "1", :event => {}
          response.should redirect_to(event_url(mock_event))
        end
      end

      describe "with invalid params" do
        it "updates the requested event" do
          Event.should_receive(:find).with("37").and_return(mock_event)
          mock_event.should_receive(:update_attributes).with({'these' => 'params'})
          # mock_event.should_receive(:update_attributes).with({'these' => 'params',
          #     'modified_by_user' => mock_admin_user })
          put :update, :id => "37", :event => { :these => 'params'}
        end

        it "assigns the event as @event" do
          Event.stub(:find).and_return(mock_event(:update_attributes => false))
          put :update, :id => "1", :event => { 'these' => 'params'}
          assigns[:event].should equal(mock_event)
        end

        it "re-renders the 'edit' template" do
          Event.stub(:find).and_return(mock_event(:update_attributes => false))
          put :update, :id => "1", :event => { 'these' => 'params'}
          response.should render_template('edit')
        end
      end

    end

    describe "DELETE destroy" do
      it "destroys the requested event" do
        Event.should_receive(:find).with("37").and_return(mock_event)
        mock_event.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the events list" do
        Event.stub(:find).and_return(mock_event(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(events_url)
      end
    end
    
    describe ":attendees, :id => required" do
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
      end
      
      it "loads an @event" do
        Event.should_receive(:find).and_return(mock_event)
        get :attendees, :id => "1"
        assigns[:event].should eql mock_event
      end
      
      it "loads all Participant model instances as @participants" do
        FakeModel.should_receive(:find).and_return([@fake_model])
        get :attendees, :id => "1"
        assigns[:participants].should eql [@fake_model]
      end
      it "renders the attendees template" do
        get :attendees, :id => "1"
        response.should render_template("events/attendees")
      end
    end
    
  end

end
