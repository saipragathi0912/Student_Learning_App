class Otp < ApplicationRecord
  belongs_to :user
  validates_presence_of :otp
end
