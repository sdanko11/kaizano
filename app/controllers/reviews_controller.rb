class ReviewsController < ApplicationController
  before_filter :does_user_own_event, :only => [:index]

  def index
    @event = Event.find(params[:event_id])
    @reviews = @event.reviews
    #look into includes
  end

  def new
    @event = Event.find(params[:event_id])
    @review = @event.reviews.build
  end

  def create
    @event = Event.find(params[:event_id])
    @review = @event.reviews.build(review_params)
    if @review.save
       redirect_to root_path
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def does_user_own_event
    all_event_ids = []
    current_user.events.each do |event|
      all_event_ids << event.id.to_s
    end
    redirect_to user_path(current_user) unless all_event_ids.include?(params[:event_id])
    #redirect to you do not have access to that event view
  end

  protected

  def review_params
    params.require(:review).permit(:feedback_comments, :rating, :event_id)
  end
end
