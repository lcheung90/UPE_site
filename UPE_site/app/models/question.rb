class Question < ActiveRecord::Base
  attr_accessible :course_level_id, :description, :title, :score
  belongs_to :user
  has_many :tags, :through =>:taggings ,:uniq => true
  has_many :taggings, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :comments
  acts_as_voteable
  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
