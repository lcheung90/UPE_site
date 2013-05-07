class Answer < ActiveRecord::Base
  attr_accessible :solution, :correct
  belongs_to :user
  belongs_to :question
  has_many :comments
  has_many :ratings
  acts_as_voteable
end
