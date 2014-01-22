class ReviewsController < ApplicationController
  before_filter :does_user_own_event, :only => [:index]

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
      @event.event_sessions.create(signed_in: "true")
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

  protected

  def review_params
    params.require(:review).permit(:feedback_comments, :rating, :event_id)
  end

end
