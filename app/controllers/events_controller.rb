class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @user  = current_user
    @event = @user.events.build(event_params)
    @event.save
  end

  def show
    @event = Event.find(params[:id])
  end

  protected

  def event_params
    params.require(:event).permit(:name, :user_id, :event_password, :location, :date, :event_url, 
    :description, :time, :user_id)
  end
  
end
