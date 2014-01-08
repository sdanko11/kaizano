require 'spec_helper'

describe QuestionVote do
  it { should belong_to(:question) }
end
