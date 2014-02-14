require 'spec_helper'

describe 'as a registered user I want to delete a event' do

    # -The user should have the option to delete an event if they navigate to the
    # edit event page
    # -If the event is sucessfully deleted the user should be directed to the user dashboard
    # and be notified that the event was deleted succesfully
    # -The user dashboard should have a a link to edit each event
    # -The user should be able to edit all attributes of an event
    # -The edit view should have a link to edit an a multi choice question if there are any present
    # -If their are any multi choice questions for the event the question body should be present
    # -If the user adds new multichoice questions they should be notified that the questions were 
    # added upon return to the edit event page
    # -If the user deletes a multi choice question they should be redirect to the edit event page
    # a be notified that the event was deleted succesfully
    # -If the user deletes a multi choice question all question answers should also be deleted
    # -The edit view should have a link to add a new multi choice question



    it "should delete the event if the delete button is clicked" do

      user = FactoryGirl.create(:user)
      FactoryGirl.create(:event, user: user)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link 'Edit Event'
      click_link "Delete Event"
    
      expect(page).to have_content "Deleted Event"
      expect(user.events.count).to eql(0)
      expect(Event.count).to eql(0)

    end

    it "should delete all associations with the event" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      review1 = FactoryGirl.create(:review, rating: 4, event: event3)
      review2 = FactoryGirl.create(:review, rating: 10, event: event3)
      review3 = FactoryGirl.create(:review, rating: 2, event: event3)
      review4 = FactoryGirl.create(:review, rating: 8, event: event3)
      review5 = FactoryGirl.create(:review, rating: 2, event: event3)
      review6 = FactoryGirl.create(:review, rating: 8, event: event3)
      question1 = FactoryGirl.create(:question, event: event3)
      question2 = FactoryGirl.create(:question, event: event3)
      question3 = FactoryGirl.create(:question, event: event3)
      question4 = FactoryGirl.create(:question, event: event3)
      question_comment = FactoryGirl.create(:question_comment, question: question3)
      question_answer = FactoryGirl.create(:question_answer, question: question1)
      multi_choice_question1 = FactoryGirl.create(:multi_choice_question, event: event3)
      multi_choice_answer1 = FactoryGirl.create(:multi_choice_answer, 
        multi_choice_question: multi_choice_question1)
      multi_choice_answer2 = FactoryGirl.create(:multi_choice_answer, 
        multi_choice_question: multi_choice_question1)
      multi_choice_answer3 = FactoryGirl.create(:multi_choice_answer, 
        multi_choice_question: multi_choice_question1)

      expect(Event.count).to eql(1)
      expect(Review.count).to eql(6)
      expect(Question.count).to eql(4)
      expect(QuestionComment.count).to eql(1)
      expect(QuestionAnswer.count).to eql(1)
      expect(MultiChoiceQuestion.count).to eql(1)
      expect(MultiChoiceAnswer.count).to eql(3)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link 'Edit Event'
      click_link "Delete Event"
    
      expect(page).to have_content "Deleted Event"
      expect(Event.count).to eql(0)
      expect(Review.count).to eql(0)
      expect(Question.count).to eql(0)
      expect(QuestionComment.count).to eql(0)
      expect(QuestionAnswer.count).to eql(0)
      expect(MultiChoiceQuestion.count).to eql(0)
      expect(MultiChoiceAnswer.count).to eql(0)

    end

    it "should should save edits" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link 'Edit Event'
      
      fill_in "Name", with: "lets talk about something"
      fill_in "Event password", with: "password"
      fill_in "Description", with: "this is gonna be awesome"

      click_button "Save Changes"
  
      expect(page).to have_content "lets talk about ..."
      expect(page).to have_content "Saved Changes"

    end

    it "should show the multi choice question body" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      multi_choice_question1 = FactoryGirl.create(:multi_choice_question, event: event3)
      multi_choice_question2 = FactoryGirl.create(:multi_choice_question, event: event3)
      multi_choice_question3 = FactoryGirl.create(:multi_choice_question, event: event3)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link 'Edit Event'
    
      expect(page).to have_content multi_choice_question1.question_body
      expect(page).to have_content multi_choice_question2.question_body
      expect(page).to have_content multi_choice_question3.question_body

    end

    it "should have a link to edit a multi choice question" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      multi_choice_question1 = FactoryGirl.create(:multi_choice_question, event: event3)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link 'Edit Event'
    
      expect(page).to have_link "Edit"

    end

    it "should have a link to add a new multi choice question" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      multi_choice_question1 = FactoryGirl.create(:multi_choice_question, event: event3)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link 'Edit Event'
    
      expect(page).to have_link "Add New Question"

    end

    it "should delete the multi choice question and all its asscociations if the user deletes a 
    multi choice question" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      multi_choice_question1 = FactoryGirl.create(:multi_choice_question, event: event3)
      multi_choice_answer1 = FactoryGirl.create(:multi_choice_answer, 
        multi_choice_question: multi_choice_question1)
      multi_choice_answer2 = FactoryGirl.create(:multi_choice_answer, 
        multi_choice_question: multi_choice_question1)
      multi_choice_answer3 = FactoryGirl.create(:multi_choice_answer, 
        multi_choice_question: multi_choice_question1)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link 'Edit Event'
      click_link 'Edit'
      click_link 'Delete Question'

      expect(page).to have_content "Deleted Question"
      expect(page).to have_content "Edit Event Details"

      expect(MultiChoiceQuestion.count).to eql(0)
      expect(event3.multi_choice_questions.count).to eql(0)

    end

    it "if a user adds multiple mulit choice questions they should be lead back to the edit event
    view when they are done adding questions" do

      user = FactoryGirl.create(:user)
      event3 = FactoryGirl.create(:event, user: user)
      multi_choice_question1 = FactoryGirl.build(:multi_choice_question, event: event3)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link 'Edit Event'
      click_link 'Add Multiple Choice Question'

      fill_in "Question", with: multi_choice_question1.question_body
      fill_in "Option A", with: multi_choice_question1.answer_b
      fill_in "Option B", with: multi_choice_question1.answer_c
      fill_in "Option C", with: multi_choice_question1.answer_c
      fill_in "Option D", with: multi_choice_question1.answer_d
      select("A", from: "Correct Answer")

      click_button "Save & Add Another Question"

      fill_in "Question", with: multi_choice_question1.question_body
      fill_in "Option A", with: multi_choice_question1.answer_b
      fill_in "Option B", with: multi_choice_question1.answer_c
      fill_in "Option C", with: multi_choice_question1.answer_c
      fill_in "Option D", with: multi_choice_question1.answer_d
      select("A", from: "Correct Answer")

      click_button "Save & Add Another Question"

      fill_in "Question", with: multi_choice_question1.question_body
      fill_in "Option A", with: multi_choice_question1.answer_b
      fill_in "Option B", with: multi_choice_question1.answer_c
      fill_in "Option C", with: multi_choice_question1.answer_c
      fill_in "Option D", with: multi_choice_question1.answer_d
      select("A", from: "Correct Answer")

      click_button "Save Question"

      expect(page).to have_content multi_choice_question1.question_body
      expect(page).to have_content "Edit Event Details"
      expect(page).to have_content "Saved"

    end

end
