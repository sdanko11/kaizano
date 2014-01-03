FactoryGirl.define do
   factory :user_with_events do
   sequence(:email) { |n| "person#{n}@example.com" } 
   first_name "Steve"
   password "12345678"
   password_confirmation "12345678"
   last_name "Danko"
   twitter_handle "@sdanko11"
  end
end