require 'spec_helper'

describe Answer do

  before do
    @answer = FactoryGirl.build(:answer)
  end

  it 'has valid title' do
    expect(@answer.title).to eq('Steve')
  end

  it 'validates title correctly' do
    answer = FactoryGirl.build(:answer, :title => nil)
    expect(answer).to be_invalid
  end
end