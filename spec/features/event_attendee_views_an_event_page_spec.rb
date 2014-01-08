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

    it "should have a field to enter a question when they visit they visit the event page" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_link "Follow me on Twitter"
      expect(page).to have_content event.description
      expect(page).to have_link "Give Feedback"
      expect(page).to have_field("Question")
      expect(page).to have_content "Question"
      expect(page).to have_button "Ask Question"
    end

      it "should show all questions if there are any questions asked" do

     
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

    it "should allow for users to up vote questions they want answered" do

      event = FactoryGirl.create(:event)
      question1 = FactoryGirl.create(:question, event: event)
      question2 = FactoryGirl.create(:question, event: event)
      question3 = FactoryGirl.create(:question, event: event)


      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"

      expect(page).to have_button "Up Vote"
    end

    it "should increase the event vote count when up vote is clicked" do

    event = FactoryGirl.create(:event)
    question1 = FactoryGirl.create(:question, event: event)


    visit root_path
    visit events_path
    fill_in "search_event_password", :with => event.event_password
    click_button "Find Event"

    expect(question1.question_votes.count).to eql(0)
    click_button "Up Vote"
    click_button "Up Vote"

    expect(page).to have_content("2")
    expect(question1.question_votes.count).to eql(2)

    end

    it "should sort questions by most votes first" do

    event = FactoryGirl.create(:event)
    question1 = FactoryGirl.create(:question, event: event)


    visit root_path
    visit events_path
    fill_in "search_event_password", :with => event.event_password
    click_button "Find Event"
    click_button "Up Vote"
    click_button "Up Vote"


    end
  end