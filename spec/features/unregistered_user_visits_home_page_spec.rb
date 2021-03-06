require 'spec_helper'

describe 'a unregisted user vistits the home page' do

  # ACCEPTANCE CRITERIA
  # Must have the option to signup
  # Must have the option to find a current event
  # Must have the company name

  context "check content on home page" do
    it "has options to create an event, register, and join a event" do

      visit root_path

      expect(page).to have_content "Kaizano"
      expect(page).to have_link "Sign Up"
      expect(page).to have_link "Create an Event"
      expect(page).to have_link "Join a Presentation"
      expect(page).to have_link "Sign In"
    end
  end

    it "should have a field for password and a find event button" do

      visit root_path
      button = page.all(:link, "Join a Presentation")
      button[0].click

      expect(page).to have_content "Enter Event Password"
      page.should have_button "Find Event"

      button[1].click
      expect(page).to have_content "Enter Event Password"
      page.should have_button "Find Event"

    end

    it "does not allow unregisted users to create an event" do 

      visit root_path
      click_link 'Create an Event'

      expect(page).to have_content "E-mail"
      expect(page).to have_content "Password"
      expect(page).to have_button "Sign up"
      expect(page).to have_field("E-mail")
      expect(page).to have_field("Password")
    
    end

    it "should direct new users to the how it works page after regstering" do

      visit new_user_registration_path
      fill_in "First Name", with: "Steve"
      fill_in "Last Name", with: "Danko"
      fill_in "E-mail", with: "steve@aol.com"
      password_field = page.all(:field, "Password")
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"

      click_button "Sign up"
  
      expect(page).to have_content "How it Works"
      expect(page).to have_link "Get Started"

      click_link "Get Started"

      expect(page).to have_content "Steve"
      expect(page).to have_content "Danko"
      expect(page).to have_content "You have no Events!"
      expect(page).to have_content "Total Presentations"

    end

    it "should not create a user if they do not fill in all the correct signup information" do

      visit new_user_registration_path

      click_button "Sign up"
  
      expect(page).to have_content "can't be blank"
      expect(page).to have_button "Sign up"

    end

    it "does not let a user register unless they specify a 8 character password" do

      visit new_user_registration_path
      fill_in "First Name", with: "Steve"
      fill_in "Last Name", with: "Danko"
      fill_in "E-mail", with: "steve@aol.com"
      password_field = page.all(:field, "pad")
      fill_in "user_password", with: "pad"
      fill_in "user_password_confirmation", with: "password"

      click_button "Sign up"
  
      expect(page).to have_content "is too short (minimum is 8 characters)"
      expect(page).to have_button "Sign up"

    end

end