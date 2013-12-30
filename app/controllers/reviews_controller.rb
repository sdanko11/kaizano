class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @event = Event.find(params[:event_id])
    @review = @event.reviews.build
  end

  def create
    @event = Event.find(params[:event_id])
    @review = @event.reviews.build(review_params)
    @review.save
  end

  def show
    @event = Event.find(params[:id])
  end

  # def update
  #   @event = Event.find(params[:id])
  #   if @event.update_attributes(event_params)
  #     redirect_to(@event)
  #   else
  #      render :edit
  #   end
  # end

  protected

  def review_params
    params.require(:review).permit(:feedback_comments, :rating, :event_id)
  end
end
