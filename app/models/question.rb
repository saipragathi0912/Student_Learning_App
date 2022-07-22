class Question < ApplicationRecord
  belongs_to :exercise
  validates_presence_of :question,:solution,:option_1,:option_2,:option_3,:option_4
end
