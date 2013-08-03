class User < ActiveRecord::Base
  has_many :quips
  attr_accessible :username
end
