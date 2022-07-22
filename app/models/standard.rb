class Standard < ApplicationRecord
    has_many :users
    validates_presence_of :classid, :color
end
