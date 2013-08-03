class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation
  has_many :quips
  has_secure_password
  validates_presence_of :password, :on => :create
end
