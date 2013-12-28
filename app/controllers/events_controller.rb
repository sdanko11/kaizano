class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = Event.all
    @event = Event.search(params[:search])
  end

  def new
    @event = Event.new
  end

  def create
    @user  = current_user
    @event = @user.events.build(event_params)
    @event.save
    if @event.save
      redirect_to user_session_path
    end
  end

  def show

  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to(@event)
    else
       render :edit
    end
  end

  protected

  def event_params
    params.require(:event).permit(:name, :user_id, :event_password, :location, :event_date, :event_url, 
    :description, :time, :user_id)
  end

end
