require 'spec_helper'

describe 'a event attendee wants to answer multi choice questions' do

  # ACCEPTANCE CRITERIA
  # -Must be a button on the event page to answer questions
  # -If the attendee has submitted answers for questions there is not button to answer multi
  # choice questions
  # -the question view for each question must include the number of questions as well as the question
  # they are on
  # Once all the questions are completed the event attendee is thanked for submitted questions



  it "should have a button answer questions on the event page if there are any 
  multi choice questions for the event" do

    event = FactoryGirl.create(:event)
    multi_choice_question = FactoryGirl.create(:multi_choice_question, event: event)

    visit events_path
    fill_in "search_event_password", with: event.event_password
    click_button "Find Event"
    expect(page).to have_link "Answer Speaker Questions"
    
  end

  it "should not have a button to answer speaker questions if there are not questions for the event" do

    event = FactoryGirl.create(:event)


    visit events_path
    fill_in "search_event_password", with: event.event_password
    click_button "Find Event"
    expect(page).to_not have_link "Answer Speaker Questions"
    
  end


  it "should show the question, all the answers, and the question breadcrumb on the answer question
  view" do

    event = FactoryGirl.create(:event)
    multi_choice_question1 = FactoryGirl.create(:multi_choice_question, event: event)
    multi_choice_question2 = FactoryGirl.create(:multi_choice_question, event: event)
    multi_choice_question3 = FactoryGirl.create(:multi_choice_question, event: event)
    multi_choice_question4 = FactoryGirl.create(:multi_choice_question, event: event)


    visit events_path
    fill_in "search_event_password", with: event.event_password
    click_button "Find Event"
    click_link "Answer Speaker Questions"
    expect(page).to have_content multi_choice_question1.question_body
    expect(page).to have_content multi_choice_question1.answer_a
    expect(page).to have_content multi_choice_question1.answer_b
    expect(page).to have_content multi_choice_question1.answer_c
    expect(page).to have_content multi_choice_question1.answer_d
    expect(page).to have_button "Submit"
    expect(page).to have_content "Question 1/4"

  end

  it "should link to the next question after submission of a question if there is another question
  to be answered, and save the answer to the database" do

    event = FactoryGirl.create(:event)
    multi_choice_question1 = FactoryGirl.create(:multi_choice_question, event: event)
    multi_choice_question2 = FactoryGirl.create(:multi_choice_question, event: event)

    visit events_path
    fill_in "search_event_password", with: event.event_password
    click_button "Find Event"
    click_link "Answer Speaker Questions"
    choose('multi_choice_answer_answer_submission_a')
    click_button "Submit"

    expect(page).to have_content multi_choice_question2.question_body
    expect(page).to have_content multi_choice_question2.answer_a
    expect(page).to have_content multi_choice_question2.answer_b
    expect(page).to have_content multi_choice_question2.answer_c
    expect(page).to have_content multi_choice_question2.answer_d
    expect(page).to have_button "Submit"
    expect(page).to have_content "Question 2/2"
    expect(event.multi_choice_questions.first.multi_choice_answers.count).to eql(1)

  end


  it "should lead to the event page after all questions are answered, the user should be
  thanked for answering questions, and there should not be a button to answer questions" do

    event = FactoryGirl.create(:event)
    multi_choice_question1 = FactoryGirl.create(:multi_choice_question, event: event)
    multi_choice_question2 = FactoryGirl.create(:multi_choice_question, event: event)

    visit events_path
    fill_in "search_event_password", with: event.event_password
    click_button "Find Event"
    click_link "Answer Speaker Questions"
    choose('multi_choice_answer_answer_submission_a')
    click_button "Submit"
    choose('multi_choice_answer_answer_submission_a')
    click_button "Submit"

    expect(page).to have_content "Answers Submitted"
    expect(page).to_not have_link "Answer Speaker Questions"
    expect(page).to have_content event.name
    expect(page).to have_content event.description
    expect(page).to have_link "Give Feedback"
    expect(page).to have_button "Ask Question"

  end

  it "should not submit a question if ther user does choose a valid submission" do

    event = FactoryGirl.create(:event)
    multi_choice_question1 = FactoryGirl.create(:multi_choice_question, event: event)
    multi_choice_question2 = FactoryGirl.create(:multi_choice_question, event: event)

    visit events_path
    fill_in "search_event_password", with: event.event_password
    click_button "Find Event"
    click_link "Answer Speaker Questions"
    click_button "Submit"

    expect(page).to have_content "Must Choose a Answer to Submit"

  end

end