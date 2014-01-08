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


  def each_event_rating_average
    @each_event_rating_average = []
    @all_ratings_from_an_event = []
    events.each do |event|
      if event.reviews.count > 0 
        event.reviews.each do |review|
         @all_ratings_from_an_event << review.rating.to_f 
        end
        review_total = @all_ratings_from_an_event.inject(0) { |sum, review| sum+=review }
        @each_event_rating_average << {event.name => (review_total/
        @all_ratings_from_an_event.count).round(2) }
        @all_ratings_from_an_event = []
      end
    end
    @each_event_rating_average
  end

  def calculate_all_presentations_average(all_event_averages)
    if all_event_averages.count > 0
      event_average_totals =[]
      all_event_averages.each do |event|
        event_average_totals << event.values.join.to_f
      end
      average_total = event_average_totals.inject(0) { |sum, review| sum+=review }
      (average_total/events_with_reviews_count).round(2)
    else
      "Make Some Events!"
    end
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

  def get_highest_rated_presentation(all_event_averages)
    if all_event_averages.count > 0
      events_sorted_by_average = all_event_averages.sort_by { |k| k.values}
      highest_rated = events_sorted_by_average.last
      "#{highest_rated.keys.join}, #{highest_rated.values.join}"
    else 
      "You have no Events!"
    end
  end

  def format_speaker_name
    "#{first_name} #{last_name}"
  end

end