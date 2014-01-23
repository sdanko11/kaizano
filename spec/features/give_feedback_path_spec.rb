require 'spec_helper'

describe 'a site visitor wants to leave feedback for a presentation' do

  # ACCEPTANCE CRITERIA
  # They must have a link to leave feedback on the home page
  # They must be able to enter in a password to access a event
  # They must give a rating for a presentation
  # They must have the option to leave general feedback for a presentation
  # They must be directed to the event page and notified that there feedback was left
  #there feedback was given
  # They should not be able to leave feedback if they already left feedback
  # They should be notified that they can not leave feedback if it was already left if they
  #try to leave feedback twice

    it "it has a link to give feedback" do

      visit root_path
      expect(page).to have_link "Join a Presentation"
      
    end

    it "should lead to a page where they enter the password" do

      visit root_path
      click_link "Join a Presentation"
      expect(page).to have_content "Enter Event Password"
      expect(page).to have_field "search_event_password"
      expect(page).to have_button "Find Event"
    end

    it "should find an event if a valid password is given" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.description
      expect(page).to have_link "Give Feedback"
    end


    it "should alert the user there are no events if they dont enter a 
    valid event password" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit events_path
      fill_in "search_event_password", :with => "not a password"
      click_button "Find Event"
      expect(page).to have_content "Password does not match any events"
      expect(page).to have_field "search_event_password"

    end

     it "should leave feedback if the user leaves a rating" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      click_link "Give Feedback"
      page.select(2, :from => "review_rating")
      click_button "Give Review"

      expect(event.reviews.count).to eql(1)
    end

    it "should not leave feedback if a rating is not added" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      click_link "Give Feedback"
      click_button "Give Review"


      expect(event.reviews.count).to eql(0)
      expect(page).to have_content "Please Give a Review"
    end

    it "should record feedback comments if they are added" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)
      review = "this was just awesome"
      rating = 3

      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      click_link "Give Feedback"
      page.select(rating, :from => "review_rating")
      fill_in "Feedback", :with => review
      click_button "Give Review"

      expect(page).to have_content user.last_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.name
      expect(page).to have_content "Review Added, Thanks."
      expect(event.reviews.count).to eql(1)
      expect(event.reviews.first.feedback_comments).to eql(review)
      expect(event.reviews.first.rating).to eql(rating)
    end

    it "does not allow for attendees to leave feedback more than once" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)
      review = "this was just awesome"
      rating = 3

      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      click_link "Give Feedback"
      page.select(rating, :from => "review_rating")
      fill_in "Feedback", :with => review
      click_button "Give Review"
      click_link "Give Feedback"

      expect(page).to have_content "Opps...Looks like you already left Feedback."
      expect(page).to have_link "Back to Event Page"
    end


    it "directs event attendees to the event page if they click the back to event button after 
    trying to leave feedback more than once" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)
      review = "this was just awesome"
      rating = 3

      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      click_link "Give Feedback"
      page.select(rating, :from => "review_rating")
      fill_in "Feedback", :with => review
      click_button "Give Review"
      click_link "Give Feedback"
      click_link "Back to Event Page"

      expect(page).to have_content user.last_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.name
      expect(event.reviews.count).to eql(1)
      expect(event.reviews.first.feedback_comments).to eql(review)
      expect(event.reviews.first.rating).to eql(rating)
    end
end