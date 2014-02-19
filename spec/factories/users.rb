# Read about factories at https://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" } 
    first_name "Steve"
    password "12345678"
    password_confirmation "12345678"
    last_name "Danko"
    twitter_handle "www.twitter.com"
    linked_in_url "www.linkedin.com"
    sign_in_count 2
    about_me "My name is steve danko"
    avatar { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'kaizano_screen_shots', 'profile.png'), 'image/png') }
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