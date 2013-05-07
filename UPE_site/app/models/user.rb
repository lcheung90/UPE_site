class User < ActiveRecord::Base
	has_secure_password
	validates :email, :presence => true,
					  :uniqueness => true,
					  :format => {:with => /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})/}
	validates :name, :presence => true
	validates :password, :presence => true,
								:length => {:minimum => 8}
	validates :username, :presence => true,
						 :uniqueness => true
	has_many :questions
	has_many :answers
	has_many :comments
	attr_accessible :email, :name, :password, :username, :tutor,:admin

	def to_param
		username
	end
	def self.search(search)
    if search
      find(:all, :conditions => ['username LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
