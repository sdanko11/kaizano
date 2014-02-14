# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
   factory :event do
   association :user
   sequence(:name) { |n| "pe#{n}ssss" }
   sequence(:description) { |n| "cool event this is a test {n}ssss" }
   sequence(:event_password) { |n| "paord#{n}" } 
   event_date Time.now
  end
end