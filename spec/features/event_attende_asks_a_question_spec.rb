require 'spec_helper'

describe 'a event attende wants to leave a question so they can better understand the 
presentation topic' do

  # ACCEPTANCE CRITERIA
  # must be a field to ask a question
  # must be a submit button to add the question


    it "should add the question if a valid question is submited" do

      event = FactoryGirl.create(:event)
      question = FactoryGirl.create(:question, event: event)

      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      fill_in "question_body", :with => question.body
      click_button "Ask Question"
      expect(Question.count).to eql(2)
      expect(page).to have_content "Question Added"
      expect(page).to have_content question.body
    end

    it "does not add a question if there is no question added" do

      event = FactoryGirl.create(:event)
      question = FactoryGirl.create(:question, event: event)


      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      fill_in "question_body", :with => ''
      click_button "Ask Question"
      expect(page).to have_content "Add a valid question to submit"

    end

end
