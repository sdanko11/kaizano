require 'spec_helper'

  describe 'as a user I want to view a individual page for a presentation, so I can
  view feedback comments see the score and view quesions' do

  # ACCEPTANCE CRITERIA
  # must show all comments for a presntaion
  # must show the feedback comments for a presentation
  # if there are no reviews or comments it should let the user know
  # it should show the presentation average rating
  # it show the number of ratings revieved
  # it should have a link to comment on questions if there are any questions present


  it "it should have the presentation and name" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    review1 = FactoryGirl.create(:review, rating: 10, event: event5)
    review2 = FactoryGirl.create(:review, rating: 10, event: event5)
    review3 = FactoryGirl.create(:review, rating: 2, event: event5)



    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"

    expect(page).to have_content event5.name
    expect(page).to have_content event5.description
      
  end

  it "should have the correct presentation rating and rating count" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    review1 = FactoryGirl.create(:review, rating: 10, event: event5)
    review2 = FactoryGirl.create(:review, rating: 10, event: event5)
    review3 = FactoryGirl.create(:review, rating: 2, event: event5)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"

    expect(page).to have_content 3
    expect(page).to have_content 7.33
      
  end

  it "should show all the feedback comments for a presentation" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    review1 = FactoryGirl.create(:review, rating: 10, event: event5)
    review2 = FactoryGirl.create(:review, rating: 10, event: event5)
    review3 = FactoryGirl.create(:review, rating: 2, event: event5)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"

    expect(page).to have_content(review1.feedback_comments)
    expect(page).to have_content(review2.feedback_comments)
    expect(page).to have_content(review3.feedback_comments)
      
  end

  it "should show all the questoions for a presentation" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    question2 = FactoryGirl.create(:question, event: event5)
    question3 = FactoryGirl.create(:question, event: event5)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"

    expect(page).to have_content(question1.body)
    expect(page).to have_content(question2.body)
    expect(page).to have_content(question3.body)

  end

  it "should show all the questoions for a presentation" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"

    expect(page).to have_link "Answer Question"

  end

  it "should lead to the answer question view when a user clicks answer question" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Answer Question"

    expect(page).to have_button("Answer Question")
    expect(page).to have_button("Answer")
    expect(page).to have_content question1.body

  end

  it "should show the question comments when a user goes to the answer question view if there
  are comments for the question" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    comment1 = FactoryGirl.create(:question_comment, question: question1)
    comment2 = FactoryGirl.create(:question_comment, question: question1)
    comment3 = FactoryGirl.create(:question_comment, question: question1)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Answer Question"

    expect(page).to have_content comment1.body
    expect(page).to have_content comment3.body
    expect(page).to have_content comment2.body
    expect(page).to have_content "Comment"

  end

  it "should have a comments header if there are not comments" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Answer Question"

    expect(page).to_not have_content "Comment"

  end

  it "should save the answer if a valid answer is added" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    comment1 = FactoryGirl.create(:question_comment, question: question1)
    comment2 = FactoryGirl.create(:question_comment, question: question1)
    comment3 = FactoryGirl.create(:question_comment, question: question1)
    answer = FactoryGirl.build(:question_answer, question: question1)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Answer Question"
    fill_in "Answer", with: answer.answer_body
    click_button "Answer Question"


    expect(QuestionAnswer.count).to eql(1)

  end

  it "should let the user know if there answer is saved succefully" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    comment1 = FactoryGirl.create(:question_comment, question: question1)
    comment2 = FactoryGirl.create(:question_comment, question: question1)
    comment3 = FactoryGirl.create(:question_comment, question: question1)
    answer = FactoryGirl.build(:question_answer, question: question1)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Answer Question"
    fill_in "Answer", with: answer.answer_body
    click_button "Answer Question"


    expect(page).to have_content "Answer Saved Succesfully"

  end

  it "should alert the user that the question answer can not be blank if they attempt to 
  submit a blank answer" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    comment1 = FactoryGirl.create(:question_comment, question: question1)
    comment2 = FactoryGirl.create(:question_comment, question: question1)
    comment3 = FactoryGirl.create(:question_comment, question: question1)
    answer = FactoryGirl.build(:question_answer, question: question1)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Answer Question"
    fill_in "Answer", with: ''
    click_button "Answer Question"

    expect(page).to have_content "can't be blank"

  end

  it "the answer button should change to a edit answer button after a question is answered by a user" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    comment1 = FactoryGirl.create(:question_comment, question: question1)
    comment2 = FactoryGirl.create(:question_comment, question: question1)
    comment3 = FactoryGirl.create(:question_comment, question: question1)
    answer = FactoryGirl.build(:question_answer, question: question1)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Answer Question"
    fill_in "Answer", with: answer
    click_button "Answer Question"

    expect(page).to have_link "Edit Answer"

  end

    it "the edit answer button should lead to the edit answer view, and allow users to edit answers" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    comment1 = FactoryGirl.create(:question_comment, question: question1)
    comment2 = FactoryGirl.create(:question_comment, question: question1)
    comment3 = FactoryGirl.create(:question_comment, question: question1)
    answer = FactoryGirl.create(:question_answer, question: question1)
    edited_answer = "this is a new answer"

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Edit Answer"

    fill_in "Answer", with: edited_answer
    click_button "Save Changes"
    expect(page).to have_content "Answer Saved Succesfully"

    visit event_path(event5)
    expect(page).to have_content edited_answer


  end

  it "should not save the answer if a valid answer is not given" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    comment1 = FactoryGirl.create(:question_comment, question: question1)
    comment2 = FactoryGirl.create(:question_comment, question: question1)
    comment3 = FactoryGirl.create(:question_comment, question: question1)
    answer = FactoryGirl.create(:question_answer, question: question1)
    edited_answer = "this is a new answer"

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Edit Answer"

    fill_in "Answer", with: ''
    click_button "Save Changes"
    expect(page).to have_content "can't be blank"

    visit event_path(event5)
    expect(page).to have_content answer.answer_body


  end

  it "the cancel button on edit answer should lead back to the review page and not save edits" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    comment1 = FactoryGirl.create(:question_comment, question: question1)
    comment2 = FactoryGirl.create(:question_comment, question: question1)
    comment3 = FactoryGirl.create(:question_comment, question: question1)
    answer = FactoryGirl.create(:question_answer, question: question1)
    edited_answer = "this is a new answer"

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Edit Answer"
    click_link "Cancel"

    expect(page).to have_content event5.name
    expect(page).to have_content event5.description
    expect(page).to have_link "View Questions"
    expect(page).to have_link "Edit Answer"

    visit event_path(event5)
    expect(page).to have_content answer.answer_body


  end


  it "should display the answer on the event page if after a presenter answers a question" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)
    comment1 = FactoryGirl.create(:question_comment, question: question1)
    comment2 = FactoryGirl.create(:question_comment, question: question1)
    comment3 = FactoryGirl.create(:question_comment, question: question1)
    answer = FactoryGirl.create(:question_answer, question: question1)

    visit events_path
    fill_in "search[event_password]", with: event5.event_password
    click_button "Find Event"
    click_link "Comments"

    expect(page).to have_content answer.answer_body

  end

  it "should let the user know if there are no questions left for an event" do

    user = FactoryGirl.create(:user)

    event5 = FactoryGirl.create(:event, user: user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"

    expect(page).to have_content "No Questions"

  end

   it "should let the user know if there are no feedback comments for a presentation" do

    user = FactoryGirl.create(:user)

    event5 = FactoryGirl.create(:event, user: user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"

    expect(page).to have_content "Audience Members left no feedback"

  end

  it "should let the user know if there are no ratings for a presentation" do

    user = FactoryGirl.create(:user)

    event5 = FactoryGirl.create(:event, user: user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"

    expect(page).to have_content "No Ratings Recieved"

  end

end