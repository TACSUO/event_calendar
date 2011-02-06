class LinksController < EventCalendar::ApplicationController
  before_filter :load_event
  
  private
    def load_event
      @event ||= Event.find(params[:event_id]) if params[:event_id]
    end
  protected
  public
    def create
      @link = @event.links.build(params[:link])
      begin
        @event.save!
        flash[:notice] = "Link successfully created."
        redirect_to event_path(@event)
      rescue ActiveRecord::RecordInvalid
        render 'events/show' and return
      end
    end
end