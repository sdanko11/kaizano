require 'spec_helper'

  describe 'the get started button is clicked on the home page' do

  # ACCEPTANCE CRITERIA
  # if the user is signed in the button should lead to the new event view
  # if the user is not signed it should lead to the sign up view


  it "should direct user to the new event view if they are signed-in" do

    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    click_link "Kaizano"
    click_link "Get Started Today!"

    expect(page).to have_content "Create New Speaking Event"
    expect(page).to have_content "Event password"
    expect(page).to have_button "Create Event"

  end

  it "should direct the user to the signup page if they are not signed in" do
    
    visit root_path
    click_link "Get Started Today!"

    expect(page).to have_content "Sign Up"
    expect(page).to have_content "Password - 8 character min"
    expect(page).to have_button "Sign up"

  end

end