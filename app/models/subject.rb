class Subject < ApplicationRecord
    has_many :chapters
    belongs_to :user
    validates_presence_of :name, :progress
end
