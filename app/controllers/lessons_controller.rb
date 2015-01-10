class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :test]
  before_filter :can_see, only: [:show, :test]
  before_filter :authorised, only: [:index, :edit, :update, :new, :destroy]

  include ApplicationHelper

  add_breadcrumb 'Home', :root_path

  def index
    add_breadcrumb 'Lessons', lessons_path

    @user = current_user
    @lessons = Lesson.all
  end

  def show
    add_breadcrumb 'Lessons', lessons_path
    add_breadcrumb @lesson.title, lesson_path(@lesson)

    @lessons = Lesson.all
    @slides = @lesson.slides
    @first_slide = @slides.first
    @user = current_user
  end

  def test
    add_breadcrumb @lesson.title, lesson_path(@lesson)
    add_breadcrumb 'Test', test_lesson_path(@lesson)

    @questions = @lesson.questions
    @lessons = Lesson.all
    @test = Test.new
  end

  # Find the next lesson which the user should attempt.
  # If they have no Test history, start from scratch.
  def current
    user = User.find(current_user.id)
    tests = Test.where('user_id = ? AND passed = ?', user.id, true) #where mark / total > 0.8
    latest = tests.maximum('lesson_id')
    next_lesson = Lesson.where('id > ?', latest).first || Lesson.first

    redirect_to lesson_path(next_lesson)
  end

  def edit
    add_breadcrumb @lesson.title, lesson_path(@lesson)
    add_breadcrumb 'Edit', edit_lesson_path(@lesson)

    @user = current_user
  end

  def new
    add_breadcrumb 'New Lesson', new_lesson_path

    @user = current_user
    @lesson = Lesson.new
    1.times do
      question = @lesson.questions.build
      2.times do
        question.answers.build
      end
      @lesson.slides.build
    end
  end

  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      flash[:success] = 'Lesson was successfully created.'
      redirect_to modify_lesson_slides_path(@lesson)
    else
      flash[:danger] = 'Error: Lesson was not created.'
      render :new
    end
  end

  def update
    if @lesson.update(lesson_params)
      flash.now[:success] = 'Lesson was successfully updated.'
      render 'edit'
    else
      flash.now[:danger] = 'Error: Lesson could not be updated.'
      render 'edit'
      #redirect_to edit_lesson_path
    end
  end

  def destroy
    @lesson.destroy
    flash[:success] = 'Lesson was successfully deleted.'
    redirect_to lessons_url
  end

  private

    # Checks whether the user is allowed to view the lesson (have progressed far enough).
    def can_see
      if !current_user.admin && progress_id(current_user) < @lesson.id
        redirect_to current_lessons_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @user = current_user
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:title, :description, :created_by, :slides_attributes => [:id, :title, :markdown, :lesson_id, :_destroy], :questions_attributes => [:id, :title, :lesson_id, :_destroy, :answers_attributes => [:id, :title, :correct, :question_id, :_destroy]])
    end
end
