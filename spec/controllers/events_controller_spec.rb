require 'spec_helper'

describe require 'spec_helper'

describe EventsController do

    describe "GET index" do
      it "assigns all events as @events" do
        Event.stub(:find).with(:all).and_return([mock_event])
        get :index
        assigns[:events].should == [mock_event]
      end
    end
    
    describe "GET index as json" do
      it "renders @events as json" do
        mock_event({
          :name => 'Some Event',
          :start_on => Date.yesterday,
          :end_on => Date.tomorrow,
          :description => 'Some Description',
          :location => 'Some City'
        })
        Event.stub(:between).and_return([mock_event])
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

end
