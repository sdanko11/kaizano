# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    sequence(:body) { |n| "This #{n}is a question" } 
  end
end
