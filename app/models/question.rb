class Question < ActiveRecord::Base
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validate :check_correct_answer
  validate :check_single_answer

  def check_correct_answer
    # Check if there is at least one correct answer

    flag = false

    self.answers.each do |answer|
      if answer.correct
        flag = true
        break
      end
    end
    unless flag
      errors.add :answers, 'must have at least one correct answer'
    end
  end

  def check_single_answer
    count = 0

    self.answers.each do |answer|
      if answer.correct
        count += 1
      end
    end

    if count > 1
      errors.add :answers, 'There must be no more than one correct answer.'
    end
  end

end
