class Test < ActiveRecord::Base
  belongs_to :lesson
  has_many :test_histories
end
