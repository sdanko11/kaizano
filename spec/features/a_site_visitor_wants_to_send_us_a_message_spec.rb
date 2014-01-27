require 'spec_helper'

describe 'a site visitor wants to send us a message to let us know how we are doing' do

  # ACCEPTANCE CRITERIA
  # Must be a form for email
  # Must be a optional field for name
  # Must be a field for message
  # must be a send button
  # they must be notified when a message is sent correctly

    it "sends a email when a user fills out the contact us form correctly" do

      ActionMailer::Base.deliveries = []

      contact = FactoryGirl.create(:contact_form)
      visit new_contact_form_path
      fill_in 'Email', with: contact.email_address
      fill_in 'Message', with: contact.message
      fill_in 'Subject', with: contact.subject
      click_button 'Send Message'

      expect(page).to have_content "Message Sent, Thanks"
      expect(ActionMailer::Base.deliveries.size).to eql(1)
      last_email = ActionMailer::Base.deliveries.last
      expect(last_email).to have_subject(contact.subject)
      expect(last_email).to have_body_text(contact.message)

    end

    it "does not send a message if a valid email is not specifed" do

      ActionMailer::Base.deliveries = []

      contact = FactoryGirl.create(:contact_form)
      visit new_contact_form_path
      fill_in 'Email', with: "email"
      fill_in 'Subject', with: contact.subject
      fill_in 'Message', with: contact.message
      click_button 'Send Message'


      expect(page).to have_content "is invalid"

    end

    it "does not send a message if the user does not add a valid message" do

      ActionMailer::Base.deliveries = []

      contact = FactoryGirl.create(:contact_form)
      visit new_contact_form_path
      fill_in 'Email', with: "email"
      fill_in 'Subject', with: contact.subject
      fill_in 'Message', with: ''
      click_button 'Send Message'


      expect(page).to have_content "can't be blank"

    end


   it "does not send a message if a valid subject is not specified" do

    ActionMailer::Base.deliveries = []

    contact = FactoryGirl.create(:contact_form)
    visit new_contact_form_path
    fill_in 'Email', with: "email"
    fill_in 'Subject', with: ''
    fill_in 'Message', with: contact.message
    click_button 'Send Message'


    expect(page).to have_content "can't be blank"

  end

end