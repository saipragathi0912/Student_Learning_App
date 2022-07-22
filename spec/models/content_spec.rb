require 'rails_helper'

RSpec.describe Content, type: :model do
  it{ should belong_to(:chapter)}
  it{ should validate_presence_of(:name)}
  it{ should validate_presence_of(:content)}
  #it{ should validate_presence_of(:watched)}
  it{ should validate_presence_of(:description)}
  #it{ should validate_presence_of(:upvote)}
  #it{ should validate_presence_of(:downvote)}
  it{ should validate_presence_of(:content_type)}
  it{ should validate_presence_of(:notes)}
end
