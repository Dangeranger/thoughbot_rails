# == Schema Information
#
# Table name: following_relationships
#
#  id               :integer          not null, primary key
#  follower_id      :integer
#  followed_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class FollowingRelationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed_user, class_name: "User"
end
