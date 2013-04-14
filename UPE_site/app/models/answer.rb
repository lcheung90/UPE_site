class Answer < ActiveRecord::Base
  attr_accessible :solution
  belongs_to :user
  belongs_to :question
  has_many :comments
  has_many :ratings
end
