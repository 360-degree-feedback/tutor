class SlidesController < ApplicationController
  before_filter :authorised
  before_action :set_lesson, :authorisation, only: [:modify]

  add_breadcrumb 'Home', :root_path

  def modify
    add_breadcrumb 'Lessons', lessons_path
    add_breadcrumb @lesson.title, lesson_path(@lesson)
    add_breadcrumb 'Edit Slides', modify_lesson_slides_path(@lesson)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    def authorisation
      if !logged_in?
        redirect_to lesson_path(Lesson.first)
      end
    end

end
