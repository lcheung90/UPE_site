class Tagging < ActiveRecord::Base
    belongs_to :tag
	belongs_to :question

	validate :question_id, :presence => true
	validate :tag_id, :presence => true#:uniqueness =>{:scope => :tag_id}
	validates_uniqueness_of :tag_id, :scope => :question_id
end
