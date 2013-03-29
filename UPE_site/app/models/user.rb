class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :username, :valid
end
