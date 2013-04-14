class Rating < ActiveRecord::Base
  attr_accessible :answer_id, :score
  belongs_to :user
  belongs_to :answer
  belongs_to :comment
end
