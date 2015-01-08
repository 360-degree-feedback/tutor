class QuestionsController < ApplicationController
  before_filter :authorised
  before_action :set_lesson, only: [:add, :modify]

  add_breadcrumb 'Home', :root_path
  def add
    @question = @lesson.questions.new
    question = @lesson.questions.build
    2.times do
      question.answers.build
    end
  end

  def modify
    add_breadcrumb 'Edit', edit_lesson_path(@lesson)
    add_breadcrumb 'Questions', modify_lesson_questions_path(@lesson)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def lesson_params
    params.require(:lesson).permit(:title, :description, :created_by, :slides_attributes => [:id, :title, :markdown, :lesson_id, :_destroy], :questions_attributes => [:id, :title, :lesson_id, :_destroy, :answers_attributes => [:id, :title, :correct, :question_id, :_destroy]])
  end

end
