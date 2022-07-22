class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  validates_presence_of :number
end
