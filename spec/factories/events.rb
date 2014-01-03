# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
   factory :event do
   sequence(:name) { |n| "pe#{n}ssss" } 
   description "this is a talk on rails"
   event_password "steve"
   association :user, stradegy: :build
  end
end