require 'spec_helper'

describe QuestionAnswer do
  
  it { should belong_to(:question) }

  it { should have_valid(:answer_body).when("This is a comment") }
  it { should_not have_valid(:answer_body).when("", nil) }

end
