# == Schema Information
#
# Table name: shouts
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  content_type :string
#  content_id   :integer
#

class Shout < ActiveRecord::Base
  DASHBOARD_TYPES = [TextShout, PhotoShout,]
  CONTENT_TYPES = DASHBOARD_TYPES
  default_scope { order(created_at: :desc) }
  belongs_to :user
  belongs_to :content, polymorphic: true

  delegate :username, to: :user

  def new_reshout
    Reshout.new(shout: self)
  end

  def self.reshouts_for(shout)
    where(content_type: "Reshout", id: shout.id)
  end

  def self.dashboard_types
    where(content_type: DASHBOARD_TYPES)
  end

end
