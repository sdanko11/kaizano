# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
   factory :event do
   association :user
   sequence(:name) { |n| "pe#{n}ssss" } 
   description "this is a talk on rails"
   event_password "steve"
  end
end