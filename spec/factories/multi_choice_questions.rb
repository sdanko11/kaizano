# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :multi_choice_question do
    sequence(:question_body) { |n| "Why should you learn to program #{n}?" }
    answer_a "this is a answer"
    answer_b "this is another good answer"
    answer_c "this is a good answer"
    answer_d "this is something good"
    answer "B"
  end
end
