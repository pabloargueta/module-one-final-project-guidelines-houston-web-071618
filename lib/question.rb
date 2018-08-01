class Question < ActiveRecord::Base
  has_many :responses
  has_many :options
  has_many :users, through: :responses

end