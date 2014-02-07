require 'spec_helper'

describe MultiChoiceQuestion do
  
  it { should have_valid(:question_body).when("this is a question body") }
  it { should_not have_valid(:question_body).when('', nil) }

  it { should have_valid(:answer_a).when("This is a possible answer") }
  it { should_not have_valid(:answer_a).when('', nil) }

  it { should have_valid(:answer_b).when("Your site is Awesome") }
  it { should_not have_valid(:answer_b).when('', nil) }

  it { should have_valid(:answer_c).when("Your site is Awesome") }
  it { should_not have_valid(:answer_c).when('', nil) }

  it { should have_valid(:answer_d).when("Your site is Awesome") }
  it { should_not have_valid(:answer_d).when("", nil) }

  it { should have_valid(:answer).when("A", "B", "C", "D") }
  it { should_not have_valid(:answer).when("", nil) }

  it { should have_many(:multi_choice_answers).dependent(:destroy) } 

end
