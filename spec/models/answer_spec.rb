require 'rails_helper'

RSpec.describe Answer, type: :model do
  it{ should validate_presence_of(:chosen_option)}
  it{ should belong_to(:question)}
  it{ should belong_to(:attempt)}
end
