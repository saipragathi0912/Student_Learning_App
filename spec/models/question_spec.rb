require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:exercise)}
  it {should validate_presence_of(:question)}
  it {should validate_presence_of(:option_1)}
  it {should validate_presence_of(:option_2)}
  it {should validate_presence_of(:option_3)}
  it {should validate_presence_of(:option_4)}
end
