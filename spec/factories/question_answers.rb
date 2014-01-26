# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question_answer do
    sequence(:answer_body) { |n| "Heres #{n}sss answer for ya." }
  end
end