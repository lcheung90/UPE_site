class Comment < ActiveRecord::Base
  attr_accessible :answer_id, :opinion_id, :user_id
end
