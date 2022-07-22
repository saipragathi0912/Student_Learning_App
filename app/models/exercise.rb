class Exercise < ApplicationRecord
  belongs_to :chapter
  validates_presence_of :total_duration,:questions, :name
end
