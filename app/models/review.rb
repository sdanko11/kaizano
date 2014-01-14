class Review < ActiveRecord::Base
  validates_presence_of :rating, message: "Please Give a Review"
  validates_length_of :rating, :maximum => 8
  belongs_to :event
  validates :rating, :numericality => { :less_than_or_equal_to => 10 }
  validates :rating, :numericality => { :greater_than_or_equal_to => 1 }

end
