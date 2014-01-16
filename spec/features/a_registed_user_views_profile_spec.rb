require 'spec_helper'

describe 'registed user signs in to kaizano' do

  context "user has events created but no reviews on the events" do

    it "has all the correct information on the profile page" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)  

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
    
      expect(page).to have_content "Kaizano"
      expect(page).to have_link "Sign out"
      expect(page).to have_link "Edit Event"
      expect(page).to have_link "View Reviews"
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.name
      expect(page).to have_content "No Reviews"
    end
  end

  context "user has events with reviews" do

     it "has all the correct content on the page" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)
      review1 = FactoryGirl.create(:review, rating: 1, event: event)
      review2 = FactoryGirl.create(:review, rating: 5, event: event)
      review3 = FactoryGirl.create(:review, rating: 10, event: event)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'

      expect(page).to have_content event.name
      expect(page).to have_content 3
      expect(page).to_not have_content "No Reviews"
      expect(page).to have_content (review2.rating + review1.rating + review3.rating)/3
      expect(page).to have_content 5.33
    end
  end

  context "check the profile page content" do

    it "it has all the correct content" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)  

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
    
      expect(page).to have_link "Sign out"
      expect(page).to have_link "Edit Event"
      expect(page).to have_link "View Reviews"
      expect(page).to have_content "Total Presentations"
      expect(page).to have_content "Presentations with Reviews"
      expect(page).to have_content "Highest Rated Presentation"
      expect(page).to have_content "Average Presentation Rating"
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.name
      expect(page).to have_link "Add Speaking Event"
      expect(page).to have_link "Edit Profile"
      expect(page).to have_content "Presentation Name"
      expect(page).to have_content "Number of Reviews"
      expect(page).to have_content "Presentation Rating"    
    end
  end

  context "Flash message displays after saving edits" do

    it "it has the correct flash message" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)  

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
      click_link 'Edit Event'
      click_button 'Save Changes'
     
      expect(page).to have_content "Saved Changes"
      expect(page).to have_content event.name
      expect(page).to have_content "Edit Event"
      expect(page).to have_content "View Reviews"
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
    end
  end

end