class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @events = Event.all
    if params[:search]
      @event = Event.find_by(event_password: params[:search][:event_password])
      if @event == nil
        flash[:could_not_find_event_notice] = "Password does not match any events"
        redirect_to events_path
      end
    end
  end
  
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
      if @event.save
        redirect_to user_session_path
      else
        flash.now[:notice] = "Please fill out all required fields."
        redenr :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:edits_saved] = "Saved Changes"
      redirect_to users_path
    else
       render :edit
    end
  end

  protected

  def event_params
    params.require(:event).permit(:name, :user_id, :event_password, :location, :event_date, 
    :event_url, :description, :time, :user_id)
  end

end
