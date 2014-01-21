require 'spec_helper'

describe ContactForm do
  
  it { should have_valid(:email_address).when("steve@aol.com") }
  it { should_not have_valid(:email_address).when("steve") }

  it { should have_valid(:message).when("this is a message kaizano is awsome") }
  it { should_not have_valid(:message).when('', nil) }

  it { should have_valid(:subject).when("Your site is Awesome") }
  it { should_not have_valid(:subject).when('', nil) }

end
