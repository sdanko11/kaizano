# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_form do
    email_address "stevedanko1@aol.com"
    subject "Good Stuff"
    name "steve danko"
    message "your site is awesome"
  end
end