require 'spec_helper'

describe User do
  it { should have_valid(:first_name).when('steve', 'bill', 'dog') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('steve@aol.com', 'bill@aol.com', 'dog@aol.com') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when('steve@aol.com', 'bill@aol.com', 'dog@aol.com') }
  it { should_not have_valid(:email).when(nil, '','steve', 'bill', 'dog') }

  it { should have_valid(:encrypted_password).when('steve', 'bill', 'dog') }
  it { should_not have_valid(:encrypted_password).when(nil, '') }

  it { should have_valid(:sign_in_count).when(12, 0) }

  it { should have_many(:events) }

end
