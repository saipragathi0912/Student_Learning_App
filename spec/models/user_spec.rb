require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:mobilenumber) }
  it { should validate_presence_of(:dob) }
  it { should validate_presence_of(:name) }
end
