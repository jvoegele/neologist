class User < ActiveRecord::Base
  has_many :quips
  attr_accessible :username, :password, :password_confirmation
  has_secure_password
end
