require 'spec_helper'

describe EventsController do  
  subject{ Event }
  let(:event) do
    mock_model(Event, {
      :name => 'Some Event',
      :event_type => 'Meeting',
      :start_on => 4.hours.from_now,
      :start_time= => 4.hours.from_now,
      :end_on => 24.hours.from_now,
      :one_day? => true,
      :timezone => 'Pacific Time (US & Canada)',
      :description => 'Some Description',
      :location => 'Some City',
      :links => mock('Relation', :build => mock_model(Link)),
      :adjust_to_utc= => nil
    })
  end
  let(:params) do
    {
      :id => "37"
    }
  end
  before(:each) do
    subject.stub(:find).with("37"){ event }
    subject.stub_chain(:past, :order){ ['past'] }
    subject.stub_chain(:current, :order){ ['current'] }
  end
  
    describe "GET index" do
      it "assigns past events as @past_events" do
        get :index
        assigns(:past_events).should eq ['past']
      end
      it "assigns current events as @current_events" do
        get :index
        assigns(:current_events).should eq ['current']
      end
    end
    
    describe "GET index as JSON" do
      context "no @events are found" do
        it "renders empty JSON container" do
          subject.stub(:between){ [] }
          get :index, :format => 'js'
          response.body.should eq("{}")
        end
      end
      context "some @events are found" do
        before(:each) do
          subject.stub(:between){ [event] }
        end
        it "renders a collection of JSON containers" do
          get :index, :start => Time.now,
                      :end => Time.now,
                      :format => 'js'
          response.body.should =~ /^\[\{.*\}\]$/
        end
        %w(id title eventType start end url className allDay details).each do |json_key|
          it "adds #{json_key} to rendered JSON" do
            get :index, :start => Time.now,
                        :end => Time.now,
                        :format => 'js'
            response.body.should include("\"#{json_key}\":")
          end
        end
      end
    end

    describe "GET show" do
      it "assigns the requested event as @event" do
        get :show, params
        assigns(:event).should eq event
      end
    end

    describe "GET new" do
      it "assigns a new event as @event" do
        subject.stub(:new){ event }
        get :new
        assigns(:event).should eq event
      end
    end

    describe "GET edit" do
      it "assigns the requested event as @event" do
        subject.stub(:find).with("37").and_return(event)
        get :edit, params
        assigns(:event).should eq event
      end
    end

    describe "POST create" do
      let :params do 
        {
          :event => {
            :start_date => Date.yesterday.to_s,
            :end_date => Date.tomorrow.to_s
          }
        }
      end
      before(:each) do
        event.stub(:save){ true }
        event.stub(:adjust_to_utc=){ true }
        subject.stub(:new){ event }
      end
      describe "with valid params" do
        it "assigns a newly created event as @event" do
          post :create, params
          assigns(:event).should eq event
        end
        it "sets adjust_to_utc to true" do
          event.should_receive(:adjust_to_utc=).with(true)
          post :create, params
        end
        it "redirects to the created event" do
          post :create, params
          response.should redirect_to event_url event
        end
      end

      describe "with invalid params" do
        before(:each) do
          event.stub(:save){ false }
        end
        it "assigns a newly created but unsaved event as @event" do
          post :create, params
          assigns(:event).should eq event
        end

        it "re-renders the 'new' template" do
          post :create, params
          response.should render_template('new')
        end
      end

    end

    describe "PUT update" do
      let :params do 
        {
          :id => "37",
          :event => {
            :start_date => Date.yesterday.to_s,
            :end_date => Date.tomorrow.to_s
          }
        }
      end
      before(:each) do
        subject.stub(:find).with("37"){ event }
        event.stub(:update_attributes){ nil }
        event.stub(:adjust_to_utc=){ true }
      end
      it "loads the @event" do
        Event.should_receive(:find).with("37"){ event }
        put :update, params
        assigns(:event).should eq event
      end
      it "sets adjust_to_utc to true" do
        event.should_receive(:adjust_to_utc=).with(true)
        put :update, params
      end
      it "updates the requested event" do
        event.should_receive(:update_attributes)
        put :update, params
      end
      it "assigns the requested event as @event" do
        put :update, params
        assigns(:event).should eq event
      end
      
      describe "with valid params" do
        before(:each) do
          event.stub(:update_attributes){ true }
        end
        
        it "sets a flash[:notice]" do
          put :update, params
          flash[:notice].should_not be_nil
        end
        it "redirects to the event" do
          put :update, params
          response.should redirect_to event_url event
        end
      end

      describe "with invalid params" do
        before(:each) do
          event.stub(:update_attributes){ false }
        end

        it "re-renders the 'edit' template" do
          put :update, params
          response.should render_template('edit')
        end
      end

    end

    describe "DELETE destroy" do
      it "destroys the requested event" do
        event.should_receive(:destroy)
        delete :destroy, params
      end

      it "redirects to the events list" do
        delete :destroy, params
        response.should redirect_to events_url
      end
    end

end
