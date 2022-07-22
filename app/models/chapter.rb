class Chapter < ApplicationRecord
  belongs_to :subject
  has_many :contents
  validates_presence_of :name
end
