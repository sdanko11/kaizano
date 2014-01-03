require 'spec_helper'

describe 'a unregisted user vistits the home page' do

  # ACCEPTANCE CRITERIA
  # Must have the option to signup
  # Must have the option to find a current event
  # Must have the company name

  context "check content on home page" do
    it "it has options to create an event and register" do

      visit root_path
      save_and_open_page

      expect(page).to have_content "Kaizano"
      expect(page).to have_content "Sign up"
      expect(page).to have_content "Create New Event"
      expect(page).to have_content "Give Feedback"
      expect(page).to have_content "sign in"
    end
  end

end