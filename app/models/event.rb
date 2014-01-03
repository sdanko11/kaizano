class Event < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :event_password
  belongs_to :user
  has_many :reviews, :dependent => :destroy
  validates_length_of :event_password, :maximum => 8

  def self.search(search)
    if search != nil
      # search = search.join
      Event.where("event_password like ?", "#{search}")
      # Event.find_by(event_password: search)
    end
  end

 def calculate_average_rating
    @all_reviews = []
    review_count = reviews.count
    reviews.each do |review|
      @all_reviews << review.rating
    end
    ratings_total = @all_reviews.inject(0) { |sum, review| sum += review }
    (ratings_total/review_count).round(2)
  end

  def count_reviews
    reviews.count
  end


  
end