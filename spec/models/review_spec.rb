require 'spec_helper'

describe Review do
  
  # it { should have_valid(:rating).when(1, 2, 3) }
  it { should_not have_valid(:rating).when('', nil) }
  it { should have_valid(:rating).when(1, 2, 3, 4) }
  it { should_not have_valid(:rating).when(12, 11, 22, -1, 0) }
  it { should have_valid(:feedback_comments).when("this is a feedback comment")}
  it { should_not have_valid(:feedback_comments).when(99999, 8888) }

  it { should belong_to(:event) }

end
