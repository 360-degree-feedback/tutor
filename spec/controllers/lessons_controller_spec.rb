require 'spec_helper'

RSpec.describe LessonsController, :type => :controller do

  describe 'Get index' do

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

  describe 'Get show' do
    context 'when logged in' do
      it 'gives success' do
        get :show
      end
    end
  end


  describe 'Post create' do
    context 'when logged in as user' do
      it 'create is not allowed' do
        login_user(FactoryGirl.build(:user))
        expect {
          post :create, lesson: FactoryGirl.attributes_for(:lesson)
        }.to_not change(Lesson, :count)
      end
    end

    context 'when logged out' do
      it 'does not allow for lesson creation' do
        expect {
          post :create, lesson: FactoryGirl.attributes_for(:lesson)
        }.to_not change(Lesson, :count)
      end
    end

    context 'when logged in as admin' do
      it 'create is successful' do
        login_user(FactoryGirl.build(:admin))
        expect {
          post :create, lesson: FactoryGirl.attributes_for(:lesson)
        }.to change(Lesson, :count).by(1)
      end
    end
  end


end