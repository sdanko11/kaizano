require 'spec_helper'

describe Event do

  it { should have_valid(:name).when('steve', 'bill', 'dog') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:description).when('sdfsdfsdf', 'this is a description', 'hahahaha') }
  it { should_not have_valid(:description).when(nil, '') }

  it { should have_valid(:event_password).when('sdfsdfsdf', 'this is a description', 'hahahaha') }
  it { should_not have_valid(:event_password).when(nil, '') }

  it { should belong_to(:user) }

  it { should have_many(:reviews)}

end
