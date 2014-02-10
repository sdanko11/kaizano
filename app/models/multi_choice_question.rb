class MultiChoiceQuestion < ActiveRecord::Base
   
   validates_presence_of :question_body
   validates_presence_of :answer_a
   validates_presence_of :answer_b
   validates_presence_of :answer_c
   validates_presence_of :answer_d
   validates_presence_of :answer
   has_many :multi_choice_answers, dependent: :destroy 
   belongs_to :event


  def check_for_answers
    if multi_choice_answers.first.nil?
      return "No Answers"
    else
      calculate_percent_of_correct_answers
    end
  end

  def calculate_percent_of_correct_answers
    correct_answers = [0, 0]
    multi_choice_answers.each do |audience_answer|
      correct_answers[1] += 1
      if audience_answer.answer_submission == answer
        correct_answers[0] += 1
      end
    end
    return ((correct_answers[0].to_f/correct_answers[1].to_f) * 100).round(2).to_s + "%"
  end


  def count_answers
    if multi_choice_answers.first.nil?
      return "No Answers"
    else
      return multi_choice_answers.count
    end
  end


end