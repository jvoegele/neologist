class Favorite < ActiveRecord::Base
  attr_accessible :quip_id, :user_id
  belongs_to :quip
  validates :quip_id, presence: true
  validates :user_id, presence: true
end
