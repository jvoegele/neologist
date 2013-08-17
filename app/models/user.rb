class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation
  has_many :quips
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :favorites, foreign_key: "user_id"
  has_many :favorite_quips, through: :favorites, source: :quip
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


  def add_favorite!(quip)
    unless self.favorite?(quip)
      favorites.create!(quip_id: quip.id)
    end
  end

  def favorite?(quip)
    favorite_quips.include?(quip)
  end

  def quip_count
    quips.count
  end

  def following?(other_user)
    followed_users.include?(other_user)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def following_count
    followed_users.count
  end

  def followers_count
    followers.count
  end

  def new_quip(attrs)
    quip = quips.build(attrs)
  end

  def latest_quips(args={count: 20})
    self.quips.all(limit: Integer(args[:count]), order: 'created_at DESC')
  end

  def timeline
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Quip.where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: self.id).order("created_at DESC")
  end
end
