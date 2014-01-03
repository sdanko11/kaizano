require 'spec_helper'

describe Review do
  
  it { should_not have_valid(:rating).when('', nil) }
  it { should have_valid(:rating).when(1, 2, 3, 4) }
  it { should_not have_valid(:rating).when(12, 11, 22, -1, 0) }
  it { should have_valid(:feedback_comments).when("this is a feedback comment")}
  it { should belong_to(:event) }

end
