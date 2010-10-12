class EventRevisionsController < ApplicationController
  def index
    if params[:id]
      @event_revision = EventRevision.find params[:id]
      redirect_to @event_revision
    end
  end
  
  def show
    @event_revision = EventRevision.find params[:id]
  end
end