# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_many :shouts

  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: "FollowingRelationship"
  has_many :followed_users,
    through: :followed_user_relationships

  has_many :follower_relationships,
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship"
  has_many :followers,
    through: :follower_relationships

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def follow(user)
    followed_users << user
  end

  def unfollow(user)
    followed_users.destroy(user)
  end

  def can_follow?(user)
    user.id != id
  end

  def following?(user)
    followed_users.where(id: user.id).exists?
  end

  def reshouted?(shout)
    shouts.reshouts_for(shout).exists?
  end

  def owns?(object)
    object.user_id == id
  end

  def reshout(shout)
    reshout = shout.new_reshout
    shouts.create(content: reshout)
  end

  def undo_reshout(shout)
    reshouts = Shout.reshouts_for(shout)
    shouts.where(id: reshouts).destroy_all
  end
end
