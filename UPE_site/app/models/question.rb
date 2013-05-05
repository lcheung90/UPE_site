class Question < ActiveRecord::Base
  attr_accessible :course_level_id, :description, :title, :score
  belongs_to :user
  has_many :tags, :through =>:taggings ,:uniq => true
  has_many :taggings, :dependent => :destroy
  has_many :answers
  has_many :comments
end
