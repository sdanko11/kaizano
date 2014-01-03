# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    feedback_comments "MyString"
    rating 10
  end
end
