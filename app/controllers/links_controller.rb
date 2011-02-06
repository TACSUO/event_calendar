class LinksController < EventCalendar::ApplicationController  
  before_filter :event, :only => [:new, :show, :edit]
  private
    def event
      @event ||= Event.find(params[:event_id])
    end
    def redirect_to_event
      redirect_to event_path params[:event_id]
    end
    def respond(&block)
      respond_to do |format|
        format.html{ yield }
        format.js
      end
    end
  protected
  public
    def new
      @link = event.links.build
    end
    def show
      @link = Link.find(params[:id])
    end
    def edit
      @link = Link.find(params[:id])
    end
    def update
      @link = Link.find(params[:id])
      if @link.update_attributes(params[:link])
        flash[:notice] = "Link successfully updated." unless request.xhr?
        event if request.xhr?
        respond{ redirect_to_event }
      else
        event
        respond{ render :edit and return }
      end
    end
    def create
      @link = event.links.build(params[:link])
      begin
        event.save!
        flash[:notice] = "Link successfully created."
        respond{ redirect_to_event }
      rescue ActiveRecord::RecordInvalid
        respond{ render 'events/show' and return }
      end
    end
    def destroy
      link = Link.find(params[:id])
      link.destroy
      flash[:notice] = "Link successfully deleted."
      redirect_to_event
    end
end