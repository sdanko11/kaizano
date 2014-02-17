require 'spec_helper'

describe 'a user wants to add a multiple choice question' do

  # ACCEPTANCE CRITERIA
  # must specify a valid question
  # must specify a valid option a
  # must specify a valid option b
  # must specify a valid option c
  # must specify a valid option d
  # must specify a valid answer
  # must be a link to go back to the dashboard
  # must be a button to save and create a new event
  # must be a button to save and go to dash board
  # must only show the sub header if the event was created 10 seconds ago

  it "should create the question and lead to the new multi choice question view if the user 
  clicks the 'Save & Add Another Question' button, and lead the user back to the dashboard once
  they submit their final question" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.build(:event, user: user)
      multi_choice_question = FactoryGirl.build(:multi_choice_question, event: event)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link "Add Speaking Event"
      fill_in "Event Name", with: event.name
      fill_in "Event password", with: event.event_password
      select("January", from: "event_event_date_2i")
      select("3", from: "event_event_date_3i")
      select("2014", from: "event_event_date_1i")
      fill_in "Event Description", with: event.description
      click_button "Create Event"

      fill_in "Question", with: multi_choice_question.question_body
      fill_in "Option A", with: multi_choice_question.answer_a
      fill_in "Option B", with: multi_choice_question.answer_b
      fill_in "Option C", with: multi_choice_question.answer_c
      fill_in "Option D", with: multi_choice_question.answer_d
      select("A", from: "Correct Answer")
      
      click_button "Save & Add Another Question"

      fill_in "Question", with: multi_choice_question.question_body
      fill_in "Option A", with: multi_choice_question.answer_a
      fill_in "Option B", with: multi_choice_question.answer_b
      fill_in "Option C", with: multi_choice_question.answer_c
      fill_in "Option D", with: multi_choice_question.answer_d
      select("A", from: "Correct Answer")
      
      click_button "Save & Add Another Question"

      fill_in "Question", with: multi_choice_question.question_body
      fill_in "Option A", with: multi_choice_question.answer_a
      fill_in "Option B", with: multi_choice_question.answer_b
      fill_in "Option C", with: multi_choice_question.answer_c
      fill_in "Option D", with: multi_choice_question.answer_d
      select("A", from: "Correct Answer")

      click_button "Save Question"

      expect(page).to have_content event.name
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_link "Edit Profile"

  end

  it "should create the question and lead to the dashboard if the user 
  clicks the 'Save Question' button" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.build(:event, user: user)
      multi_choice_question = FactoryGirl.build(:multi_choice_question, event: event)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link "Add Speaking Event"
      fill_in "Event Name", with: event.name
      fill_in "Event password", with: event.event_password
      select("January", from: "event_event_date_2i")
      select("3", from: "event_event_date_3i")
      select("2014", from: "event_event_date_1i")
      fill_in "Event Description", with: event.description
      click_button "Create Event"

      fill_in "Question", with: multi_choice_question.question_body
      fill_in "Option A", with: multi_choice_question.answer_a
      fill_in "Option B", with: multi_choice_question.answer_b
      fill_in "Option C", with: multi_choice_question.answer_c
      fill_in "Option D", with: multi_choice_question.answer_d
      select("A", from: "Correct Answer")
      click_button "Save Question"

      expect(MultiChoiceQuestion.count).to eql(1)
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.name
      expect(page).to have_content "Total Presentations"
      expect(page).to_not have_button "Save & Go to Dashboard"
      expect(page).to_not have_button "Save & Add Another Question"

  end

  it "should have a 'Go to Dashboard' link that leads back to the users dashboard" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)
      multi_choice_question = FactoryGirl.build(:multi_choice_question, event: event)


      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      visit new_event_multi_choice_question_path(event)
      click_link 'Go to Dashboard'


      expect(event.multi_choice_questions.count).to eql(0)
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_content event.name
      expect(page).to have_content "Total Presentations"
      expect(page).to_not have_button "Save & Go to Dashboard"
      expect(page).to_not have_button "Save & Add Another Question"

  end

  it "should not create a multi choice question if the user does not add a valid question" do

    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    multi_choice_question = FactoryGirl.build(:multi_choice_question, event: event)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    visit new_event_multi_choice_question_path(event)

    fill_in "Option A", with: multi_choice_question.answer_a
    fill_in "Option B", with: multi_choice_question.answer_b
    fill_in "Option C", with: multi_choice_question.answer_c
    fill_in "Option D", with: multi_choice_question.answer_d
    select("A", from: "Correct Answer")
    click_button "Save & Add Another Question"

    expect(event.multi_choice_questions.count).to eql(0)
    expect(page).to have_content "can't be blank"

  end

  it "should not create a multi choice question if the user does not add a valid option A" do

    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    multi_choice_question = FactoryGirl.build(:multi_choice_question, event: event)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    visit new_event_multi_choice_question_path(event)

    fill_in "Question", with: multi_choice_question.question_body
    fill_in "Option B", with: multi_choice_question.answer_b
    fill_in "Option C", with: multi_choice_question.answer_c
    fill_in "Option D", with: multi_choice_question.answer_d
    select("A", from: "Correct Answer")
    click_button "Save Question"

    expect(event.multi_choice_questions.count).to eql(0)
    expect(page).to have_content "can't be blank"

  end

  it "should not create a multi choice question if the user does not add a valid option B" do

    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    multi_choice_question = FactoryGirl.build(:multi_choice_question, event: event)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    visit new_event_multi_choice_question_path(event)

    fill_in "Question", with: multi_choice_question.question_body
    fill_in "Option A", with: multi_choice_question.answer_b
    fill_in "Option C", with: multi_choice_question.answer_c
    fill_in "Option D", with: multi_choice_question.answer_d
    select("A", from: "Correct Answer")
    click_button "Save Question"

    expect(event.multi_choice_questions.count).to eql(0)
    expect(page).to have_content "can't be blank"

  end

  it "should not create a multi choice question if the user does not add a valid option C" do

    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    multi_choice_question = FactoryGirl.build(:multi_choice_question, event: event)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    visit new_event_multi_choice_question_path(event)

    fill_in "Question", with: multi_choice_question.question_body
    fill_in "Option A", with: multi_choice_question.answer_b
    fill_in "Option B", with: multi_choice_question.answer_c
    fill_in "Option D", with: multi_choice_question.answer_d
    select("A", from: "Correct Answer")
    click_button "Save Question"

    expect(event.multi_choice_questions.count).to eql(0)
    expect(page).to have_content "can't be blank"

  end

  it "should not create a multi choice question if the user does not add a valid option D" do

    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    multi_choice_question = FactoryGirl.build(:multi_choice_question, event: event)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    visit new_event_multi_choice_question_path(event)

    fill_in "Question", with: multi_choice_question.question_body
    fill_in "Option A", with: multi_choice_question.answer_b
    fill_in "Option B", with: multi_choice_question.answer_c
    fill_in "Option C", with: multi_choice_question.answer_d
    select("A", from: "Correct Answer")
    click_button "Save Question"

    expect(event.multi_choice_questions.count).to eql(0)
    expect(page).to have_content "can't be blank"

  end

  it "should not create a multi choice question if the user does not add a valid answer" do

    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    multi_choice_question = FactoryGirl.build(:multi_choice_question, event: event)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    visit new_event_multi_choice_question_path(event)

    fill_in "Question", with: multi_choice_question.question_body
    fill_in "Option A", with: multi_choice_question.answer_b
    fill_in "Option B", with: multi_choice_question.answer_c
    fill_in "Option C", with: multi_choice_question.answer_c
    fill_in "Option D", with: multi_choice_question.answer_d
    click_button "Save Question"

    expect(event.multi_choice_questions.count).to eql(0)

  end

  it "should not show the sub header if the event was created more than 10 seconds ago" do

    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    Timecop.travel(Time.now + 11)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit new_event_multi_choice_question_path(event)
    expect(page).to_not have_content "Use multiple choice questions to gauge how 
    well your audience is grasping the topic your presenting on."
    expect(page).to_not have_content "Add Multiple Choice Question"
    expect(page).to have_content "Add New Multiple Choice Question"


  end

  it "should show the sub header if the event was in the last 10 seconds" do

    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit new_event_multi_choice_question_path(event)
    expect(page).to have_content "Use multiple choice questions to gauge how 
    well your audience is grasping the topic your presenting on."
    expect(page).to have_content "Add Multiple Choice Question"

  end


end