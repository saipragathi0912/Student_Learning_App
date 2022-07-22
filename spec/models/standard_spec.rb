require 'rails_helper'

RSpec.describe Standard, type: :model do
  #it {should have_many(:users)}
  it { should validate_presence_of(:classid) }
  it { should validate_presence_of(:color) }
end
