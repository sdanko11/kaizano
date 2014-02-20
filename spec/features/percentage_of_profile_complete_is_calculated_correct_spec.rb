require 'spec_helper'

describe 'a registered user should know how much they have to go before thier profile is coplete' do

  # ACCEPTANCE CRITERIA
  # the correct percentage of thier profile complete should be displayed on the users dashboard
  # first name, last name, email, and password accounts for 20%
  # about you accounts for 35%
  # twitter and linked in accounts for 20% 
  # profile photo accounts for 25%

  it "not state the percentage of profile completed if the profile is 100% complete" do

    user = FactoryGirl.create(:user)
    
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to_not have_content "Profile is 100% complete"
    
  end

  it "should be 65% completion if there is no about me" do
    
    user = FactoryGirl.create(:user, about_me: nil)
    
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content "Profile is 65% complete"

  end

  it "should be 90% completion if there is no twitter handle" do

    user = FactoryGirl.create(:user, twitter_handle: nil)
    
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content "Profile is 90% complete"

  end

  it "should be 90% completion if there is no linked in url" do

    user = FactoryGirl.create(:user, linked_in_url: nil)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content "Profile is 90% complete"

  end

  it "should be 75% if no profile photo" do

    user = FactoryGirl.create(:user, avatar: nil)
    
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content "Profile is 75% complete"


  end

end