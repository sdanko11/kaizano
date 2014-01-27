require 'spec_helper'

describe 'a register user wants to sign in' do

  # ACCEPTANCE CRITERIA
  # Must be able click a link for a new event
  # Must be able to add a event name
  # Must be able to add a event description
  # Must be able to add a event password

    it "directs the user to the profile page following sing in" do

      user = FactoryGirl.create(:user)
      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'

      expect(page).to have_link "Add Speaking Event"
      expect(page).to have_link "Sign out"
      expect(page).to have_link "Join a Presentation"
      expect(page).to have_content "Total Presentations"
      expect(page).to have_content "Presentations with Reviews"
      expect(page).to have_content "Average Presentation Rating"
      expect(page).to have_content "Highest Rated Presentation"
      expect(page).to have_link "Edit Profile"
      expect(page).to have_content "Presentation Name"
      expect(page).to have_content "Number of Reviews"
      expect(page).to have_content "Presentation Rating"
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
    end



end