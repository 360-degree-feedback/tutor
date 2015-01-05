class Lesson < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :slides, dependent: :destroy
  has_many :answers, through: :questions
  accepts_nested_attributes_for :questions, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :slides, :reject_if => :all_blank, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true
end
