class Review < ActiveRecord::Base
  validates_presence_of :rating, message: "Please Give a Review"
  validates_length_of :rating, :maximum => 8
  belongs_to :event
  validates :rating, :numericality => { :less_than_or_equal_to => 10 }
  validates :rating, :numericality => { :greater_than_or_equal_to => 1 }


  # def stuff
  #   binding.pry
  #   @all_reviews = []
  #   review_count = event.reviews.count
  #   event.reviews.each do |review|
  #     @all_reviews << review.rating
  #   end
  #   ratings_total = @all_reviews.inject(0) { |sum, review| sum += review }
  #   (ratings_total/review_count).round(2)
  # end
  
end
