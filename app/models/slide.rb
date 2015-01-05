class Slide < ActiveRecord::Base
  belongs_to :lesson

  validates :title, presence: true
  validates :markdown, presence: true
end
