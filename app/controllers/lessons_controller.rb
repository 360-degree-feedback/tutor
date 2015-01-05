class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :test, :mark, :result]

  include ApplicationHelper

  # GET /lessons
  # GET /lessons.json
  def index
    if !logged_in?
      redirect_to lesson_path(Lesson.first)
    end

    @user = current_user
    @lessons = Lesson.all
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lessons = Lesson.all
    @slides = @lesson.slides
    @first_slide = @slides.first
    @user = current_user
  end

  def test
    @questions = @lesson.questions
    @lessons = Lesson.all
  end

  def mark
    @questions = @lesson.questions
    @correct = 0

    @questions.each do |question|
      answer = question.answers.find_by(correct: true)
      @correct += 1 if params[question.id.to_s] == answer.id.to_s
    end
    #flash[:success] = 'Answers successfully submitted.'
    redirect_to result_lesson_path(@lesson, :correct => @correct, :questions => @questions.count)
  end

  def result
    @correct = params[:correct]
    #@questions = params[:questions]
    @lessons = Lesson.all
  end

  # GET /lessons/new
  def new
    if !logged_in?
      redirect_to lesson_path(Lesson.first)
    end
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

  # GET /lessons/1/edit
  def edit
    @user = current_user
    if !logged_in?
      redirect_to lesson_path(Lesson.first)
    end
  end

  # POST /lessons
  # POST /lessons.json
  def create
    if !logged_in?
      redirect_to lesson_path(Lesson.first)
    end
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html {
          #flash[:success] = 'Lesson was successfully created.'
          redirect_to modify_lesson_slides_path(@lesson)
        }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    if !logged_in?
      redirect_to lesson_path(Lesson.first)
    end

    respond_to do |format|
      if @lesson.update(lesson_params)
        #flash[:success] = 'Lesson was successfully updated.'
        format.html { redirect_to @lesson }

      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html {
        flash[:success] = 'Lesson was successfully deleted.'
        redirect_to lessons_url }
      format.json { head :no_content }
    end
  end

  def slide
    @slides = @lesson.slides
    @slide = @slides.find(params[:slide_id])

    if request.xhr?
      render :json => {
                 :title => @slide.title,
                 :markdown => @slide.markdown
             }
    end
  end



  private
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
