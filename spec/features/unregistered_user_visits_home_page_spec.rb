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
      expect(page).to have_link "Create a Event"
      expect(page).to have_link "Find Event"
      expect(page).to have_link "Sign In"
    end
  end

    it "should have a field for password and a find event button" do

      visit root_path
      click_link 'Find Event'

      expect(page).to have_content "Enter Event Password"
      page.should have_button "Find Event"

    end

    it "does not allow unregisted users to create an event" do 

      visit root_path
      click_link 'Create a Event'

      expect(page).to have_content "Email"
      expect(page).to have_content "Password"
      expect(page).to have_button "Sign in"
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
    
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
      expect(page).to have_content "Create a Speaking Event"
      expect(page).to have_content "Give your Event Password to your Audience."
      expect(page).to have_content "Recieve Feedback and Questions from your Audience."
      expect(page).to have_button "Get Started"

    end

end