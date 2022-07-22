class Answer < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  validates_presence_of :chosen_option
end
