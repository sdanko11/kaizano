class QuestionComment < ActiveRecord::Base
  
  validates_presence_of :body
  
  belongs_to :question
  
end
