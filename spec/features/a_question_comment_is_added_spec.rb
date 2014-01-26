require 'spec_helper'

    describe 'a event attende or user wants to leave a comment for a pre-existing question
    so they can help those who have questions better understand' do

    # ACCEPTANCE CRITERIA
    # must be a field to add a comment
    # must be a submit button to add the comment
    # must display the comment on the page after it is asked

    it "should have all a field to ask a comment" do

      event = FactoryGirl.create(:event)
      question = FactoryGirl.create(:question, event: event)


      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      expect(page).to have_field "Comment"
      expect(page).to have_button "Comment"
    end

    it "add a comment if a valid comment is added" do

      event = FactoryGirl.create(:event)
      question = FactoryGirl.create(:question, event: event)
      comment = FactoryGirl.create(:question_comment)


      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      fill_in "Comment", :with => comment.body
      click_button "Comment"
      expect(page).to have_content comment.body
    end

    it "should not add a comment if a valid comment is not added" do

      event = FactoryGirl.create(:event)
      question = FactoryGirl.create(:question, event: event)

      visit root_path
      visit events_path
      fill_in "search_event_password", :with => event.event_password
      click_button "Find Event"
      click_button "Comment"
      expect(QuestionComment.count).to eql(0)

    end

  end
