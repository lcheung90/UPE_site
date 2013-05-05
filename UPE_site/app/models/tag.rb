class Tag < ActiveRecord::Base
  	has_many :taggings, :dependent => :destroy
	has_many :questions, :through => :taggings

	validates :name, :uniqueness => true,
					 :length => {:in => 1..15},
					 :format => {:with => /^\w+$/}

	attr_accessible :name
	def to_param
		name
	end
end
