class Question < ActiveRecord::Base
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validate :check_correct_answer

  def check_correct_answer
    # Check if there is at least one correct answer
    errors.add :answers, 'must have one correct answer' unless answers.one? { |answer| answer.correct }
  end

end
