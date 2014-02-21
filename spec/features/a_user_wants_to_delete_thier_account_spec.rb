require 'spec_helper'

describe 'a user wants to delete thier account spec' do

  # ACCEPTANCE CRITERIA
  # must delete the account a direct the user to the home page
  # must notify the user that the account was succesfully deleted 
  # must delete all associations with the account

  it "should delete the account and all associations with the users" do

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
    click_link 'Edit Profile'
    click_link "Delete Account"
  
    expect(page).to have_content "Hone your Presentation Skills
    We Make it Easy to Connect with your Audience and Improve your Presentation Skills."
    
    expect(page).to have_content "Account deleted, we're sorry to lose you."
    
    expect(User.count).to eql(0)
    expect(Event.count).to eql(0)
    expect(Review.count).to eql(0)
    expect(Question.count).to eql(0)
    expect(QuestionComment.count).to eql(0)
    expect(QuestionAnswer.count).to eql(0)
    expect(MultiChoiceQuestion.count).to eql(0)
    expect(MultiChoiceAnswer.count).to eql(0)

  end

end