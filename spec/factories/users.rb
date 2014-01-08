# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
   factory :user do
   sequence(:email) { |n| "person#{n}@example.com" } 
   first_name "Steve"
   password "12345678"
   password_confirmation "12345678"
   last_name "Danko"
   twitter_handle "www.twitter.com"
  end
end