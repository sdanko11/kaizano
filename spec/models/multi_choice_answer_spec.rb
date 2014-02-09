require 'spec_helper'

describe MultiChoiceAnswer do
  
  it { should belong_to(:multi_choice_question) }

  it { should have_valid(:answer_submission).when("A") }

  it { should_not have_valid(:answer_submission).when(nil,'') }

end
