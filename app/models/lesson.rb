class Lesson < ActiveRecord::Base
  has_many :questions,-> {order 'questions.id'}, dependent: :destroy
  has_many :slides, -> {order 'slides.id'}, dependent: :destroy
  has_many :answers, -> {order 'answers.id'},through: :questions
  has_many :tests, dependent: :destroy
  accepts_nested_attributes_for :questions, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :slides, :reject_if => :all_blank, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true
end
