require 'spec_helper'

describe 'a site visitor wants to learn more about kaizano' do

  # ACCEPTANCE CRITERIA
  # Must be a link to Learn More
  # Learn More link must lead to learn more section
  # Must be a link to get started on learn more page
  # Must be page content about the product
  # If the user is signed it the get started button takes them to their dashboard
  # if the user is not signed in it takes them to the signup page

  it "should have link to learn more" do

    visit root_path
    expect(page).to have_link "Learn More"

  end

  it "has learn more content on the page" do

      visit root_path
      click_link "Learn More"

      expect(page).to have_content "Improve Your Public Speaking"
      expect(page).to have_content "Connect with your Audience"
      expect(page).to have_content "Honest Audience Feedback"
      expect(page).to have_content "Multiple Choice Questions"
      expect(page).to have_content "Your Dashboard"
      expect(page).to have_link "Get Started"
      
  end

  it "leads a user to the dashboard after they click the get started button if they are signed in" do

      user = FactoryGirl.create(:user)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      visit root_path
      click_link "Learn More"

      click_link "Get Started"
      expect(page).to have_link "Add Speaking Event"

  end

  it "leads a visor to the sign up page if they are not signed in after visting the learn more page" do

      visit root_path
      click_link "Learn More"
      click_link "Get Started"

      expect(page).to have_content "Sign Up"
      expect(page).to have_button "Sign up"

  end

end
