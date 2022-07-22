require 'rails_helper'

RSpec.describe Exercise, type: :model do
  it {should belong_to(:chapter)}
  it { should validate_presence_of(:total_duration)}
  it { should validate_presence_of(:questions)}
  it { should validate_presence_of(:name)}
end
