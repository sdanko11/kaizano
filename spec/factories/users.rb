# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
   factory :user do
   sequence(:email) { |n| "person#{n}@example.com" } 
   first_name "Steve"
   password "12345678"
   password_confirmation "12345678"
   last_name "Danko"
   twitter_handle "www.twitter.com"
   sign_in_count 2
   about_me "My name is steve danko"
  end
end

FactoryGirl.define do
   factory :user2 do
   sequence(:email) { |n| "person#{n}@example.com" } 
   first_name "Steve"
   password "1222678"
   password_confirmation "1222678"
   last_name "Danko"
   twitter_handle "www.twitter.com"
   about_me "My names is bob."
  end
end