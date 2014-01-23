require 'spec_helper'

describe 'site visitor who has not entered correct event password can not view event' do

  # ACCEPTANCE CRITERIA
  # event show pages should not be accesable unless a correct password is entered

    it "does not allow site visitors to visit the event show page if 
    they dont enter the correct password" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit root_path
      visit event_path(event)
      
    end

    it "does not allow signed in users to visit the event show page if 
    they dont enter the correct password" do

      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user2.email
      fill_in 'Password', :with => user2.password
      click_button 'Sign in'
      visit event_path(event)
      
      expect(page).to have_button "Find Event"
      expect(page).to have_content "Enter Event Password"
    end

end