class MultiChoiceQuestion < ActiveRecord::Base
   
   validates_presence_of :question_body
   validates_presence_of :answer_a
   validates_presence_of :answer_b
   validates_presence_of :answer_c
   validates_presence_of :answer_d
   validates_presence_of :answer
   has_many :multi_choice_answers, dependent: :destroy 

end