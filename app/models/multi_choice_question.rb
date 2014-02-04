class MultiChoiceQuestion < ActiveRecord::Base
   
   validates_presence_of :question_body
   validates_presence_of :answer_a
   validates_presence_of :answer_b
   validates_presence_of :answer_c
   has_many :multi_choice_answer_submissions, dependent: :destroy
   has_one :multi_choice_answer

end
