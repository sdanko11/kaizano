class ReviewsController < ApplicationController
  before_filter :does_user_own_event, :only => [:index]
  before_filter :have_they_entered_password?, only: [:new]


  def index
    @event = Event.find(params[:event_id])
    @reviews = @event.reviews
  end

  def new
    @event = Event.find(params[:event_id])
    @review = @event.reviews.build
  end

  def create
    @event = Event.find(params[:event_id])
    @review = @event.reviews.build(review_params)
    if @review.save
      event_id = params[:event_id]
      session["#{event_id}"] = "added review"
      flash[:review_saved] = "Review Added, Thanks."
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def does_user_own_event
    if user_signed_in?
      all_event_ids = []
      current_user.events.each do |event|
        all_event_ids << event.id.to_s
      end
      redirect_to user_path(current_user) unless all_event_ids.include?(params[:event_id])
    else
      redirect_to root_path
    end
  end

  def have_they_entered_password?
    if session[:events_authenticated].present? && !user_signed_in?
      render status: 404 unless session[:events_authenticated].include?(params[:event_id])
      event_id = params[:event_id]
      if session["#{event_id}"].present?
        redirect_to left_feedbacks_path
      end
    elsif user_signed_in?
      signed_in_user_authentication
    else
      render status: 404
    end
  end

  def signed_in_user_authentication
    event_id = params[:event_id]
    if session["#{event_id}"].present?
      redirect_to left_feedbacks_path
    else
      event = Event.find(params[:event_id])
      render status: 404 unless current_user.id == event.user_id ||
      session[:events_authenticated].include?(params[:event_id])
    end
  end

  protected

  def review_params
    params.require(:review).permit(:feedback_comments, :rating, :event_id)
  end

end
