class MultiChoiceAnswer < ActiveRecord::Base
  
  validates_presence_of :answer_submission
  belongs_to :multi_choice_question

end