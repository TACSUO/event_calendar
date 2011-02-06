class LinksController < EventCalendar::ApplicationController  
  private
    def event
      @event ||= Event.find(params[:event_id])
    end
    def redirect_to_event
      redirect_to event_path params[:event_id]
    end
  protected
  public
    def edit
      event
      @link = Link.find(params[:id])
    end
    def update
      @link = Link.find(params[:id])
      if @link.update_attributes(params[:link])
        flash[:notice] = "Link successfully updated."
        redirect_to_event
      else
        event
        render :edit and return
      end
    end
    def create
      @link = event.links.build(params[:link])
      begin
        event.save!
        flash[:notice] = "Link successfully created."
        redirect_to_event
      rescue ActiveRecord::RecordInvalid
        render 'events/show' and return
      end
    end
    def destroy
      link = Link.find(params[:id])
      link.destroy
      flash[:notice] = "Link successfully deleted."
      redirect_to_event
    end
end