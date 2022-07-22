require 'rails_helper'

RSpec.describe Subject, type: :model do
  it {should belong_to(:user)}
  it {should have_many(:chapters)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:progress)}
end
