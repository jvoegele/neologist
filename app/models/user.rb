class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation
  has_many :quips
  has_secure_password

  validates :password, on: :create,
      presence: true,
      length: { minimum: 6, maximum: 24 }

  validates :username, presence: true,
      uniqueness: {
        message: "%{value} has already been taken."
      },
      length: { minimum: 3, maximum: 16 },
      format: {
        with: /^\w+$/i,
        message: 'must contain only alphanumeric characters.'
      }


  def latest_quips(args={count: 20})
    self.quips.all(limit: Integer(args[:count]), order: 'created_at DESC')
  end
end
