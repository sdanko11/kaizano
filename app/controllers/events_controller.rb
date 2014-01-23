class EventsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :does_user_own_event, :only => [:edit]
  before_filter :did_they_enter_password?, only: [:show]

  def index
    session[:events_authenticated] = [] if session[:events_authenticated].nil?
    if params[:search]
      @event = Event.find_by(event_password: params[:search][:event_password])
      if @event == nil
        flash[:could_not_find_event_notice] = "Password does not match any events."
        redirect_to events_path
      else
        session[:events_authenticated] << @event.id.to_s
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

  def did_they_enter_password?
    if !session[:events_authenticated].present?
      session[:events_authenticated] = []
    end
    if current_user.nil?
      redirect_to events_path unless session[:events_authenticated].include?(params[:id])
    else 
      event = Event.find(params[:id])
      redirect_to events_path unless current_user.id == event.user_id || session[:events_authenticated].include?(params[:id])
    end
  end

  protected

  def event_params
    params.require(:event).permit(:name, :user_id, :event_password, :location, :event_date, 
    :event_url, :description, :time)
  end

end