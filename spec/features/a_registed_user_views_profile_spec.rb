require 'spec_helper'

describe 'registed user views audience feedback' do

context "check the profile page content" do

    it "it has all available options to create an event" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)  

      visit root_path
      click_link 'Sign in'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
      click_link 'Profile'
    
      expect(page).to have_content "Kaizano"
      expect(page).to have_link "Sign out"
      expect(page).to have_link "Edit Event"
      expect(page).to have_link "View Reviews"
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.name
    
    end
  end

  context "Check the event review page" do

     it "has all the correct event information" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)
      review1 = FactoryGirl.create(:review, rating: 1, event: event)
      review2 = FactoryGirl.create(:review, rating: 5, event: event)
      review3 = FactoryGirl.create(:review, rating: 10, event: event)

      visit root_path
      click_link 'Sign in'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
      click_link 'Profile'
      click_link 'View Reviews'

      expect(page).to have_content "Kaizano"
      expect(page).to have_link "Sign out"
      expect(page).to have_content "Event Title"
      expect(page).to have_content event.name
      expect(page).to have_content event.description
      expect(page).to have_content review1.feedback_comments
      expect(page).to have_content review2.feedback_comments
      expect(page).to have_content "Average Rating"
      expect(page).to have_content (review2.rating + review1.rating + review3.rating)/3
      expect(page).to have_content 5.33
    end
  end

  context "check the profile page content" do

    it "it has all available options to create an event" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)  

      visit root_path
      click_link 'Sign in'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
      click_link 'Profile'
    
      expect(page).to have_content "Kaizano"
      expect(page).to have_link "Sign out"
      expect(page).to have_link "Edit Event"
      expect(page).to have_link "View Reviews"
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.name
    
    end
  end

   context "check the edit page content" do

    it "it has all the availabel options to edit an event" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)  

      visit root_path
      click_link 'Sign in'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
      click_link 'Profile'
      click_link 'Edit Event'
    
      expect(page).to have_content "Kaizano"
      expect(page).to have_link "Sign out"
      expect(page).to have_content "Name"
      expect(page).to have_content "Event url"
      expect(page).to have_content "Edit Event Details"
      expect(page).to have_content "Description"
      find_field('Name').value.should eq event.name
      find_field('Description').value.should eq event.description
      expect(page).to have_button "Save Changes"
    
    end
  end

  context "Flash message displays after saving edits" do

    it "it has the correct flash message" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)  

      visit root_path
      click_link 'Sign in'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
      click_link 'Profile'
      save_and_open_page
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