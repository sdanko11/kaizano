require 'spec_helper'

describe Review do
  
  # it { should have_valid(:rating).when(1, 2, 3) }
  it { should_not have_valid(:rating).when('', nil) }
  it { should have_valid(:rating).when(1, 2, 3, 4) }

  it { should belong_to(:event) }

end
