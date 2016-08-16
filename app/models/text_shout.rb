# == Schema Information
#
# Table name: text_shouts
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TextShout < ActiveRecord::Base
  def index_content
    body
  end
end
