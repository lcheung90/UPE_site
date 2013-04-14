class Comment < ActiveRecord::Base
  attr_accessible :answer_id, :opinion_id, :user_id
  belongs_to :user_id
  belongs_to :question
  belongs_to :answer_id
  has_many :ratings
end
