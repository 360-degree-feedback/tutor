class SlidesController < ApplicationController
  before_action :set_lesson, :authorisation, only: [:add, :modify]

  def add
    @slide = @lesson.slides.new
    @lesson.slides.build
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      #params.require(:slide).permit(:title, :markdown, :lesson_id)
      params.require(:lesson).permit(:slides_attributes => [:id, :title, :markdown, :lesson_id, :_destroy])
    end
end
