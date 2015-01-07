class TestsController < ApplicationController

  def index

  end

  def show
    # Shows all answers to questions and mark obtained.
    @test = Test.find(params[:id])
    @lesson = Lesson.find(@test.lesson_id)
    @lessons = Lesson.all
    @test_histories = @test.test_histories
    @questions = @lesson.questions
  end

  def display
    # Shows all tests taken by a particular user.
    @tests = Test.where(user_id: params[:user_id])
  end

  def add

    @lesson = Lesson.find(params[:lesson_id])
    @questions = @lesson.questions
    correct = 0
    correct_flag = false

    # Create Test
    @test = Test.create do |test|
      test.lesson_id = params[:lesson_id]
      test.user_id = params[:user_id]
    end

    # Create each Test_History
    @questions.each do |question|
      answer = question.answers.find_by(correct: true)
      correct += 1 if params[question.id.to_s] == answer.id.to_s

      TestHistory.create do |history|
        history.test_id = @test.id
        history.question_id = question.id
        history.answer_id = params[question.id.to_s].to_i # Convert answer to integer.
        history.correct = true if params[question.id.to_s] == answer.id.to_s
      end
    end

    # Add mark and total to Test
    Test.update(@test.id, :mark => correct)
    Test.update(@test.id, :total => @questions.count)

    if (correct/@questions.count) > 0.8
      Test.update(@test.id, :passed => true)
    else
      Test.update(@test.id, :passed => false)
    end
    redirect_to @test

  end

end
