class QuestionAnswer < ActiveRecord::Base
  
  validates_presence_of :answer_body
  
  belongs_to :question
  
end
