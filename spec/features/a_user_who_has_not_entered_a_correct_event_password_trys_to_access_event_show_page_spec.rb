require 'spec_helper'

describe 'site visitor who has not entered correct event password can not view event' do

  # ACCEPTANCE CRITERIA
  # event show pages should not be accesable unless a correct password is entered

    it "does not allow site visitors to visit the event show page if 
    they dont enter the correct password" do

      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, user: user)

      visit root_path
      visit event_path(event)

    end

end