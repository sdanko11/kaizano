class Review < ActiveRecord::Base
  validates_presence_of :rating
  belongs_to :event
end
