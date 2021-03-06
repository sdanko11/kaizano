class Event < ActiveRecord::Base
  
  validates_presence_of :name
  
  validates_presence_of :description
  
  validates_length_of :description, :maximum => 500
  
  validates_presence_of :event_password
  
  validates_presence_of :event_date
  
  validates :event_password, uniqueness: true
  
  belongs_to :user
  
  has_many :reviews, 
    dependent: :destroy

  has_many :questions, 
    dependent: :destroy
  
  has_many :multi_choice_questions, 
    dependent: :destroy
  
  validates_length_of :event_password, :maximum => 8
  
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

  def count_questions
    multi_choice_questions.count
  end

  def question_number(question)
    all_questions = multi_choice_questions.load
    return all_questions.index(question) + 1
  end

  def format_speaker_name
    "#{user.first_name} #{user.last_name}"
  end

  def format_date
    event_date.to_date.strftime("%b %e, %Y")
  end

  def any_multi_choice_questions?
    if multi_choice_questions.count > 0
      true
    else
      false
    end
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