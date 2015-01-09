require 'spec_helper'

RSpec.describe LessonsController, :type => :controller do

  describe 'Get Lesson' do

    context 'when logged in as user' do
      it 'redirects to a lesson' do
        login_user(FactoryGirl.build(:user))
        get :index
        expect(response.status).to eq(302)
      end

    end

    context 'when logged out' do
      it 'redirects to welcome' do
        get :index
        expect(response).to redirect_to(welcome_url)
      end
    end

    context 'when logged in as admin' do
      it 'gives success' do
        login_user(FactoryGirl.build(:admin))
        get :index
        expect(response.status).to eq(200)
      end
    end

  end

  describe 'Get Test' do
    before do
      @lesson = FactoryGirl.create(:lesson)
    end
  end
end