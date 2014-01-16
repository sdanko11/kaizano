require 'spec_helper'

describe 'registed user attempts visits the home page' do

  # ACCEPTANCE CRITERIA
  # Must be able click a link for a new event
  # Must be able to add a event name
  # Must be able to add a event description
  # Must be able to add a event password

  context "check content on home page" do
    it "it has options to create an event and register" do

      user = FactoryGirl.create(:user)
      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'

      expect(page).to have_content "Kaizano"
      expect(page).to_not have_link "Sign up"
      expect(page).to have_link "Create New Event"
      expect(page).to have_link "Give Feedback"
      expect(page).to_not have_link "Sign In"
      expect(page).to have_link "Sign out"
    end
  end

   context "check content on home page" do
    it "it has options to create an event and register" do

      user = FactoryGirl.create(:user)
      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
      click_link 'Sign out'

      expect(page).to have_content "Kaizano"
      expect(page).to have_link "Sign up"
      expect(page).to have_link "Create New Event"
      expect(page).to have_link "Give Feedback"
      expect(page).to have_link "Sign in"
      expect(page).to_not have_link "Sign out"
    end
  end

     context "check content on create event page" do
      
     it "it has all available options to create an event" do

      user = FactoryGirl.create(:user)
      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
      click_link 'Add Speaking Event'
    
      expect(page).to have_content "Kaizano"
      expect(page).to have_link "Sign out"
      expect(page).to have_content "Name"
      expect(page).to have_content "Description"
      expect(page).to have_content "Location"
      expect(page).to have_content "Event url"
      expect(page).to have_button "Create Event"
      expect(page).to have_field "Name"
      expect(page).to have_field "Description"
      expect(page).to have_field "Location"
      expect(page).to have_field "Event url"
    end
  end

end