class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @events = Event.all

    if params[:search]
      # @event = Event.search(params[:search][:event_password])
      @event = Event.find_by(event_password: params[:search][:event_password])
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    @event = Event.new(event_params)
    @event.user = current_user

    @event.save
    if @event.save
      redirect_to user_session_path
    end
  end

  def show
    @event = Event.find(params[:id])
    # @review = Review.new
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
