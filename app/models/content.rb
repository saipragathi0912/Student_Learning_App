class Content < ApplicationRecord
  belongs_to :chapter
  validates_presence_of :name,:content,:description,:notes,:content_type
end
