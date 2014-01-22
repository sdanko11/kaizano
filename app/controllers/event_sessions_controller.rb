class EventSessionsController < ApplicationController

  def create
    password = params[:event_session].values.join
    @event = Event.where("event_password like ?", "#{password}")
    if @event[0]
    @event.event_sessions.build(event_session_params)
      event = event[0].id
      redirect_to event_path(event)
    else 
      redirect_to events_path
    end
  end


  def event_session_params
    params.require(:event_session).permit(:signed_in, :event_key)
  end


end