require 'spec_helper'

describe EventsController do  
  subject{ Event }
  let(:event) do
    mock_model(Event, {
      :name => 'Some Event',
      :start_on => Date.yesterday,
      :end_on => Date.tomorrow,
      :timezone => 'Pacific Time (US & Canada)',
      :description => 'Some Description',
      :location => 'Some City'
    })
  end
  let(:params) do
    {
      :id => "37"
    }
  end
  before(:each) do
    subject.stub(:find).with("37"){ event }
  end
  
    describe "GET index" do
      it "assigns all events as @events" do
        subject.stub(:all){ [event] }
        get :index
        assigns(:events).should eq [event]
      end
    end
    
    describe "GET index as json" do
      it "renders @events as json" do
        subject.stub(:between).and_return([event])
        get :index, :format => 'js'
        response.should be_success
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
        subject.stub(:new){ event }
      end
      describe "with valid params" do
        it "assigns a newly created event as @event" do
          post :create, params
          assigns(:event).should eq event
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
      end  
      it "updates the requested event" do
        Event.should_receive(:find).with("37"){ event }
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
