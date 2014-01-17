class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :does_user_own_event, :only => [:edit]

  def index
    @events = Event.all
    if params[:search]
      @event = Event.find_by(event_password: params[:search][:event_password])
      if @event == nil
        flash[:could_not_find_event_notice] = "Password does not match any events."
        redirect_to events_path
      else
        redirect_to event_path(@event)
      end
    end
  end
  
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
      if @event.save
        redirect_to user_path(current_user)
      else
        flash.now[:notice] = "Please fill out all required fields."
        render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:saved] = "Saved Changes"
      redirect_to user_path(current_user)
    else
       render :edit
    end
  end

  def show
    @question_comment = QuestionComment.new
    @question_vote = QuestionVote.new
    @question = Question.new
    @event = Event.find(params[:id])
  end

  def does_user_own_event
    all_event_ids = []
    current_user.events.each do |event|
      all_event_ids << event.id.to_s
    end
    redirect_to user_path(current_user) unless all_event_ids.include?(params[:id])
  end

  protected

  def event_params
    params.require(:event).permit(:name, :user_id, :event_password, :location, :event_date, 
    :event_url, :description, :time)
  end

end
