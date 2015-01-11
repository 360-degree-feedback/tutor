class TestsController < ApplicationController

  include ApplicationHelper

  add_breadcrumb 'Home', :root_path

  # Shows all answers to questions and mark obtained.
  def show
    @test = Test.find(params[:id])
    @lesson = Lesson.find(@test.lesson_id)

    add_breadcrumb @lesson.title, lesson_path(@lesson)
    add_breadcrumb 'Test', test_lesson_path(@lesson)
    add_breadcrumb 'Result', test_path(@test)

    @lessons = Lesson.all
    @test_histories = @test.test_histories
    @questions = @lesson.questions
  end

  # Displays a particular user's test history.
  def display
    # If the user is not an admin AND isn't viewing their own test, redirect.
    if !current_user.admin && params[:user_id] != current_user.id.to_s
      redirect_to welcome_path
    end

    add_breadcrumb 'Tests', display_tests_path(:user_id => params[:user_id])

    unless params[:user_id]
      @tests = Test.all
    else
      @user = User.find(params[:user_id])
      @tests = Test.where(user_id: params[:user_id])
    end
  end

  # Adds a test history to the db from a test that has just been taken.
  def add
    @lesson = Lesson.find(params[:lesson_id])
    @questions = @lesson.questions

    correct = 0

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
