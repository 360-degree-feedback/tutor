require 'spec_helper'

RSpec.describe LessonsController, :type => :controller do

  describe 'POST Mark' do

    before do
      @lesson = FactoryGirl.create(:lesson)
    end

    it 'should redirect to result and return send mark' do
      post :mark, id: @lesson.id
      expect(response).to redirect_to result_lesson_path(@lesson, :correct => 0, :questions => 0)
    end


  end

  describe 'Get Test' do
    before do
      @lesson = FactoryGirl.create(:lesson)
    end


  end
end