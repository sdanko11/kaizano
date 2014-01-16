require 'spec_helper'

describe 'as a registed user with events and ratings I want to check my
    rating scores' do

    it "should calculate the correct amount of total presentations" do

      user = FactoryGirl.create(:user)
      FactoryGirl.create(:event, user: user)
      FactoryGirl.create(:event, user: user)
      FactoryGirl.create(:event, user: user)
      FactoryGirl.create(:event, user: user)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
    
      expect(page).to have_content 4
      expect(user.events.count).to eql(4)

    end

      it "should calculate the correct amount of amount of presentations with reviews" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      review1 = FactoryGirl.create(:review, event: event3)
      review2 = FactoryGirl.create(:review, event: event3)
      review3 = FactoryGirl.create(:review, event: event3)
      
      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
    
      expect(page).to have_content 3
      expect(user.events.first.reviews.count).to eql(3)

    end

      it "should calculate the correct amount of amount of presentations with reviews" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      review1 = FactoryGirl.create(:review, event: event3)
      review2 = FactoryGirl.create(:review, event: event3)
      review3 = FactoryGirl.create(:review, event: event3)
      
      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
    
      expect(page).to have_content 3
      expect(user.events.first.reviews.count).to eql(3)

    end

    it "should calculate the correct Average Presentation Rating" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      event4 = FactoryGirl.create(:event, user: user)
      event5 = FactoryGirl.create(:event, user: user)
      event6 = FactoryGirl.create(:event, user: user)
      review1 = FactoryGirl.create(:review, rating: 4, event: event5)
      review2 = FactoryGirl.create(:review, rating: 10, event: event5)
      review3 = FactoryGirl.create(:review, rating: 2, event: event6)
      review1 = FactoryGirl.create(:review, rating: 8, event: event6)
      review2 = FactoryGirl.create(:review, rating: 2, event: event3)
      review3 = FactoryGirl.create(:review, rating: 8, event: event3)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
    
      expect(page).to have_content 5.67

    end

    it "It shoudld calculate the correct highest rated presentaion" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      event4 = FactoryGirl.create(:event, user: user)
      event5 = FactoryGirl.create(:event, user: user)
      event6 = FactoryGirl.create(:event, user: user)
      review1 = FactoryGirl.create(:review, rating: 10, event: event5)
      review2 = FactoryGirl.create(:review, rating: 10, event: event5)
      review3 = FactoryGirl.create(:review, rating: 2, event: event6)
      review1 = FactoryGirl.create(:review, rating: 8, event: event6)
      review2 = FactoryGirl.create(:review, rating: 2, event: event3)
      review3 = FactoryGirl.create(:review, rating: 8, event: event3)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'

      expect(page).to have_content 10
      highest_rated = user.get_highest_rated_presentation(user.each_event_rating_average)
      expect(highest_rated).to eql("#{event5.name}, 10.0")
    end

    it "It shoudld calculate the correct highest rated presentaion" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      event4 = FactoryGirl.create(:event, user: user)
      event5 = FactoryGirl.create(:event, user: user)
      event6 = FactoryGirl.create(:event, user: user)
      review1 = FactoryGirl.create(:review, rating: 10, event: event5)
      review2 = FactoryGirl.create(:review, rating: 10, event: event5)
      review3 = FactoryGirl.create(:review, rating: 2, event: event6)
      review1 = FactoryGirl.create(:review, rating: 8, event: event6)
      review2 = FactoryGirl.create(:review, rating: 2, event: event3)
      review3 = FactoryGirl.create(:review, rating: 8, event: event3)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'

      expect(page).to have_content 10
      highest_rated = user.get_highest_rated_presentation(user.each_event_rating_average)
      expect(highest_rated).to eql("#{event5.name}, 10.0")
      
    end
  end
