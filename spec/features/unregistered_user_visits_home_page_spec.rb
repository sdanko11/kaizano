require 'spec_helper'

describe 'a unregisted user vistits the home page' do

  # ACCEPTANCE CRITERIA
  # Must have the option to signup
  # Must have the option to find a current event
  # Must have the company name

  context "check content on home page" do
    it "has options to create an event and register" do

      visit root_path

      expect(page).to have_content "Kaizano"
      expect(page).to have_link "Sign up"
      expect(page).to have_link "Create New Event"
      expect(page).to have_link "Give Feedback"
      expect(page).to have_link "Sign in"
      expect(page).to_not have_content "Profile"
    end
  end

  context " check content on find the enter event password page" do
    it "should have a field for password and a find event button" do

      visit root_path
      click_link 'Give Feedback'

      expect(page).to have_content "Enter Event Password"
      page.should have_button "Find Event"
    end
  end

  context "Unregistered users should be redirected to sign-in 
  page if they try to create an event" do
    it "it has the fields to create a new event" do 

      visit root_path
      click_link 'Create New Event'

      expect(page).to have_content "Email"
      expect(page).to have_content "Password"
      expect(page).to have_button "Sign in"
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
    end
  end

    it "should direct new users to the how it works page after regstering" do

      visit root_path
      click_link 'Sign Up'
      fill_in "E-mail", :with => "steve@aol.com"
      fill_in "Password", :with => "ssteve11"
      fill_in "Confirm Password", :with => "ssteve11"
      fill_in "First Name", :with => "Steve"
      fill_in "Last Name", :with => "Danko"
      click_button "Sign up"

      expect(page).to have_content "How it Works"
      expect(page).to have_button "Get Started"

    end

end