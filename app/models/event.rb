class Event < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description
  validates_length_of :description, :maximum => 500

  validates_presence_of :event_password
  validates :event_password, uniqueness: true
  belongs_to :user
  has_many :reviews
  validates_length_of :event_password, :maximum => 8
  has_many :questions, dependent: :destroy

  def self.search(search)
    if search != nil
      Event.where("event_password like ?", "#{search}")
    end
  end

 def calculate_average_rating
    @all_reviews = []
    review_count = count_reviews
      reviews.each do |review|
        @all_reviews << review.rating.to_f
      end
    ratings_total = @all_reviews.inject(0) { |sum, rating| sum += rating }
    (ratings_total/review_count).round(2)
  end

  def count_reviews
    reviews.count
  end

  def format_speaker_name
    "#{user.first_name} #{user.last_name}"
  end

  def parse_name
    event_name = name
    if event_name.length > 15
      "#{event_name[0..15]}" + "..."
    else
      "#{event_name}"
    end
  end

end