require 'rails_helper'

RSpec.describe Chapter, type: :model do
  it{ should belong_to(:subject)}
  it{ should have_many(:contents)}
  it{ should validate_presence_of(:name)}
end
