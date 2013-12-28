class ReviewsController < ApplicationController

 def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @event = Event.find(params[:event_id])
    @review = @event.reviews.build(review_params)
  end

  # def show
  #   @event = Event.find(params[:id])
  # end

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
