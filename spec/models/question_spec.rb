require 'spec_helper'

describe Question do
  it { should have_valid(:body).when("This is a questions about your presentation") }
  it { should_not have_valid(:body).when(nil, '') }

  it { should belong_to(:event) }

  it { should have_many(:question_votes) }

end
