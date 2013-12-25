class Review < ActiveRecord::Base
  validates_presence_of :rating, :in => 1..10
  belongs_to :event
end
