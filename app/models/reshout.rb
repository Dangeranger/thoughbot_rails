class Reshout < ActiveRecord::Base
  belongs_to :shout

  def index_content
    nil
  end
end
