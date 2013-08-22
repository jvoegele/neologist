class Quip < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :user_id
  validates :content, presence: true, length: {minumum: 2, maximum: 140}

  default_scope order: 'quips.created_at DESC'
end
