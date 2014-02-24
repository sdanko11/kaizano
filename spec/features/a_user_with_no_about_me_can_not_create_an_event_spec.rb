require 'spec_helper'

  describe 'as a registered user I am not able to create an event without haveing the
  about me present on my profile' do

  # ACCEPTANCE CRITERIA
  # if a user attempts to create an event with no about me present on their profile they should
  # be redirected to a form to enter their about me.


  it "should redirect the user to the about me form from the home page if the user does
  not have about me present" do

    user = FactoryGirl.create(:user, about_me: nil)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    click_link "Kaizano"
    click_link "Create an Event"

    expect(page).to have_content "About You"
    expect(page).to have_content "Let the audience know who you are."
    expect(page).to have_button "Next"

  end

  it "should redirect the user to the about me form from the home page if the user about me
  is an empty string" do

    user = FactoryGirl.create(:user, about_me: '          ')

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    click_link "Kaizano"
    click_link "Create an Event"

    expect(page).to have_content "About You"
    expect(page).to have_content "Let the audience know who you are."
    expect(page).to have_button "Next"

  end

  it "directss the user to the new event page if they have about me present" do

    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    click_link "Kaizano"
    click_link "Create an Event"


    expect(page).to have_content "Create New Speaking Event"
    expect(page).to have_content "Event Name"
    expect(page).to have_content "Location"
    expect(page).to have_content "Event Description"
    expect(page).to have_button "Create Event"

  end

end