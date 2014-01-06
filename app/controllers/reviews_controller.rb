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
    if @review.save
       redirect_to root_path
    else
      render :new
    end
  end

  def show
    binding.pry
    @review = Review.find(params[:id])
  end

  protected

  def review_params
    params.require(:review).permit(:feedback_comments, :rating, :event_id)
  end
end
