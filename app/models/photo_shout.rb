# == Schema Information
#
# Table name: photo_shouts
#
#  id                 :integer          not null, primary key
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class PhotoShout < ActiveRecord::Base
  has_attached_file :photo
  validates_attachment :photo, content_type: {
    content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  }

  def index_content
    photo_file_name.split('.').join(' ')
  end
end
