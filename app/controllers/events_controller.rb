class EventsController < EventCalendar::ApplicationController

  layout "event-calendar"
  
  # before_filter :load_and_authorize_current_user, :except => [:index, :show]
  
  # GET /events
  # GET /events.xml
  def index
    @events = Event.find :all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js do
        json = @events.map do |e|
          e.to_hash_for_calendar(event_calendar.event_path(e))
        end
        render :json => json.to_json
      end
    end
  end

  def search
    # TODO render a search results page instead of a calendar
    @events = Event.search(params[:q],
      :narrow_fields => params[:fields] ? params[:fields].keys : nil).paginate :page => params[:page]
  end
  
  # GET /events/1
  # GET /events/1.xml
  def show
    # @event = Event.find(params[:id], :include => :file_attachments)
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    # @event.modified_by_user = current_user

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(event_calendar.event_path(@event)) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      # if @event.update_attributes(params[:event].merge(:modified_by_user => current_user))
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    respond_to do |format|
      format.html { redirect_to(event_calendar.events_path) }
      format.xml  { head :ok }
    end
  end

  # def drop_contact
  #   @event = Event.find(params[:id])
  #   if @event.drop_attendees(params[:contact_ids] || params[:contact_id])
  #     flash[:notice] = "Contact(s) removed from #{@event.name} roster."
  #   else
  #     flash[:warning] = "Failed to remove contact(s) from #{@event.name} roster. (#{@event.errors.full_messages.join('; ')}"
  #   end
  #   redirect_to @event
  # end

  # def add_attendees
  #   @event = Event.find(params[:id])
  #   @contacts_not_in_group = Contact.find(:all, :order => 'last_name, first_name',
  #     :conditions => 'last_name IS NOT NULL AND last_name != ""') - @event.contacts
  # end

  # def add_contacts
  #   @event = Event.find(params[:id])
  #   if @event.add_attendees(params[:contact_ids])
  #     flash[:notice] = "Contacts(s) added to #{@event.name}."
  #   else
  #     flash[:warning] = "Failed to add contact(s) to #{@event.name}. (#{@event.errors.full_messages.join('; ')}"
  #   end
  #   redirect_to @event
  # end
end
