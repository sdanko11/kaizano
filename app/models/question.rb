class Question < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :body
  has_many :question_votes
end
