# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question_comment do
    sequence(:body) { |n| "Heres #{n}sss question for yas" } 
  end
end
