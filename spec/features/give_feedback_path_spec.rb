require 'spec_helper'

describe 'a site visitor wants to leave feedback for a presentation' do

  # ACCEPTANCE CRITERIA
  # They must have a link to leave feedback on the home page
  # They must be able to enter in a password to access a event
  # They must give a rating for a presentation
  # They must have the option to leave general feedback for a presentation
  # They must be directed to the home page after feedback is left and be notified
  #there feedback was given

    it "it has a link to give feedback" do

      visit root_path
      expect(page).to have_link "Give Feedback"
      
    end

    it "it should lead to a page where they enter the password" do

      visit root_path
      click_link "Give Feedback"
      expect(page).to have_content "Enter Event Password"
      expect(page).to have_button "Find Event"
    end
end