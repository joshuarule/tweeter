class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  validates_presence_of :handle
  validates_uniqueness_of :handle #makes sure there is a unique handle

  #self referencing join

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower                                    

  def following?(other_user)
    self.relationship.find_by(followed_id: other_user.id)
  end

  def following!(other_user)
    self.relationship.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationship.find_by(followed_id: other_user.id).destroy
  end


end
