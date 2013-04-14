class Question < ActiveRecord::Base
  attr_accessible :course_level_id, :description, :title
  belongs_to :user
  has_many :answers
  has_many :comments
end
