require 'spec_helper'

describe 'a registered user wants to create a speaking event' do

  # ACCEPTANCE CRITERIA
  # Must be a link to create an event on the user dashboard
  # User must specify the name
  # User must specify the event password
  # password must be unique
  # user must specify the description
  # must have the option to add a location
  # must have the option to add a event url
  # -if the event is succefully created the user should be lead to create new multi
  # choice queston view
  # event must not be saved if all required fields are not added

  it "should have a button to create a event on the user dashboard" do

      user = FactoryGirl.create(:user)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      visit user_path(user)

      expect(page).to have_link "Add Speaking Event"
  end

  it "should have create a event if all required fields are added && lead to new multi choice 
  question creation" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.build(:event, user: user)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      visit user_path(user)
      click_link "Add Speaking Event"
      fill_in "Event Name", with: event.name
      fill_in "Event password", with: event.event_password
      select("January", from: "event_event_date_2i")
      select("3", from: "event_event_date_3i")
      select("2014", from: "event_event_date_1i")
      fill_in "Event Description", with: event.description
      click_button "Create Event"

      expect(Event.count).to eql(1)
      expect(page).to have_content "Add Multiple Choice Question"
      expect(page).to have_button "Save & Add Another Question"
      expect(page).to have_button "Save Question"
      expect(page).to have_content "Use multiple choice questions to gage how well
      your audience is grasping the topic your presenting on."

  end

  it "should not create a event if all the required fields are not added" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.build(:event, user: user)

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      visit user_path(user)
      click_link "Add Speaking Event"
      fill_in "Event Name", with: ''
      fill_in "Event password", with: ''
      fill_in "Event Description", with: ''
      click_button "Create Event"

      expect(Event.count).to eql(0)
      expect(page).to have_content "can't be blank"
      expect(page).to have_content "Create New Speaking Event"

  end

  it "should not create a event if the event password is not unique" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.build(:event, user: user)
      event.save!

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      visit user_path(user)
      click_link "Add Speaking Event"
      fill_in "Event Name", with: event.name
      fill_in "Event password", with: event.event_password
      fill_in "Event Description", with: event.description
      click_button "Create Event"

      expect(Event.count).to eql(1)
      expect(page).to have_content "has already been taken"
      expect(page).to have_content "Create New Speaking Event"

  end

  it "should not create event if a event description longer than 500 characters is added" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.build(:event, user: user)
      event_description = 'This is a sting that is longer that 500 characeters
      isasdfkljdsafkjhsadfkjlsahdfkjlsadfhaslkdfjhsdalkfjhasdflkjhasdfjklahsdfkjlsadhfsakjldfhaskljdfha
      jskldfhasdkjlfhasdlkjfhsadflksajdhfaslkdjfhsadkjfhsadlkjfhasdlkfjhsadflkasdfkljsadfklasdfjaklsdfh
      jasjkldfhasdlkjfhasdlkfjhasdjklfhadsfkljhasdflkasdjhfalksdfjhasldkjfhaslkdjfhasdklfjhasdflkjsahdfl
      kasdjfhasldfjhasdlfjkhasdflsadkjfhasldkjfhasldkjfhsadkljfhasdflkjhsadfljksadfsdfkljsadfkjhsadfljkh
      asdflaskdjfhsadlkfjhasdflkasdjfhasldkfjhsadlkjfhasdlfkjhsadfklsadfj'

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      visit user_path(user)
      click_link "Add Speaking Event"
      fill_in "Event Name", with: event.name
      fill_in "Event password", with: event.event_password
      fill_in "Event Description", with: event_description
      click_button "Create Event"
      
      expect(Event.count).to eql(0)
      expect(page).to have_content "is too long (maximum is 500 characters)"      

  end
  
end
