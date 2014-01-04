class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :encrypted_password
  validates_presence_of :sign_in_count
  has_many :events
  belongs_to :event
  mount_uploader :avatar, ImageUploader


  def get_each_presentation_average
    @each_event_average = []
    @all_events_from_each_review = []
    events.each do |event|
      if event.reviews.count > 0 
        event.reviews.each do |review|
         @all_events_from_each_review << review.rating.to_f 
        end
        review_total = @all_events_from_each_review.inject(0) { |sum, review| sum+=review }
        @each_event_average << (review_total/@all_events_from_each_review.count).round(2)
        @all_events_from_each_review = []
      end
    end
    calculate_all_presentations_average
  end

  def calculate_all_presentations_average
    average_total = @each_event_average.inject(0) { |sum, review| sum+=review }
    (average_total/events_with_reviews_count).round(2)
  end

  def events_with_reviews_count
   @count = 0
    events.each do |event|
      if event.reviews.count > 0
        @count +=1
      end
    end
    @count
  end

end