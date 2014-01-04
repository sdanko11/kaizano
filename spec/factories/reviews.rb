# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    sequence(:feedback_comments) { |n| "good presentation#{n} man" }
    rating 1
  end
end
