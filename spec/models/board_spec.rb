require 'rails_helper'

RSpec.describe Board, type: :model do
  it {should have_many(:users)}
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:logo) }
  it { should validate_presence_of(:color) }
  it { should validate_presence_of(:boardid)}
end
