class User < ActiveRecord::Base
  has_many :responses
  has_many :questions, through: :responses
  # needed to be attached to scores
  has_many :scores
end