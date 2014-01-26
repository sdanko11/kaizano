require 'spec_helper'

describe 'a event attendee vistits a event page so they can review a event, ask questions,
and leave feedback for the presentation to further there undestading of presentation content"
' do

  # ACCEPTANCE CRITERIA
  # *All event details must be displayed
  # *must be a submit button to add the question
  # *if there are any existing questions for the event they are displayed
  # *there is an option to up vote exisitng questions if there are any existing questions for
  # the event
  # *there is an option to 
  # *if there are multple questions with votes they should sorted by most votes first
  # *if there are not votes on questions they should be sorted by most recent add 

    it "should display information about the presentation and the speaker" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.description

    end

    it "should have a link to give feedback" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      

      expect(page).to have_link "Give Feedback"

    end

    it "should show all questions if there are any questions asked" do

     
      event = FactoryGirl.create(:event)
      question1 = FactoryGirl.create(:question, event: event)

      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      expect(page).to have_content question1.body

    end

    it "should have a field and button to ask a question" do

      event = FactoryGirl.create(:event)

      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"

      expect(page).to have_field "question_body"
      expect(page).to have_button "Ask Question"
      expect(page).to have_content "Ask a Question"
    end

    it "should have all existing questions listed if there are any questions" do

      event = FactoryGirl.create(:event)
      question1 = FactoryGirl.create(:question, event: event)
      question2 = FactoryGirl.create(:question, event: event)
      question3 = FactoryGirl.create(:question, event: event)

      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      
      expect(page).to have_content question1.body
      expect(page).to have_content question2.body
      expect(page).to have_content question3.body

    end

      it "should have a link to show comments if there are any questions" do

      event = FactoryGirl.create(:event)
      question1 = FactoryGirl.create(:question, event: event)

      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      
      expect(page).to have_link "Comments"

      end

      it "should not have a comments link if there are not audience questions for a presentation" do

      event = FactoryGirl.create(:event)
    
      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      
      expect(page).to_not have_link "Comments"

      end

      it "should not show question comments unless the user cicks the comment link" do

      event = FactoryGirl.create(:event)
      question1 = FactoryGirl.create(:question, event: event)
      comment1 = FactoryGirl.create(:question_comment) 
      comment2 = FactoryGirl.create(:question_comment)
      comment3 = FactoryGirl.create(:question_comment)
    
      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      
      expect(page).to_not have_content comment1.body
      expect(page).to_not have_content comment2.body
      expect(page).to_not have_content comment3.body

      end

      it "should not show question comments unless the user cicks the comment link" do

      event = FactoryGirl.create(:event)
      question1 = FactoryGirl.create(:question, event: event)
      comment1 = FactoryGirl.create(:question_comment, question: question1)
      comment2 = FactoryGirl.create(:question_comment, question: question1)
      comment3 = FactoryGirl.create(:question_comment, question: question1)

    
      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      click_link "Comments"
      
      expect(page).to have_content comment1.body
      expect(page).to have_content comment2.body
      expect(page).to have_content comment3.body

      end
  end