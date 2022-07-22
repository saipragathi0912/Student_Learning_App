class Board < ApplicationRecord
    has_many :users
    validates_presence_of :name,:logo,:boardid,:color
end
