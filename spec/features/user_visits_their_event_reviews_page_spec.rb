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

    expect(page).to have_link "Comment"

  end

  it "should lead back to the event review page when a user clicks the views the comment for page" do

    user = FactoryGirl.create(:user)
    event5 = FactoryGirl.create(:event, user: user)
    question1 = FactoryGirl.create(:question, event: event5)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
    click_link "View Reviews"
    click_link "Comment"


    current_path.should == event_path(event5)

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