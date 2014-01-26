require 'spec_helper'

describe QuestionComment do

   it { should belong_to(:question) }
   it { should have_valid(:body).when("This is a comment") }
   it { should_not have_valid(:body).when("", nil) }

end
