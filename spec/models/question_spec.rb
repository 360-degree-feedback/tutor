require 'spec_helper'

describe Question do

  before do
    @question = FactoryGirl.build(:question)
  end

  it 'has valid title' do
    expect(@question.title).to eq('What is your name?')
  end

  it 'validates title correctly' do
    question = FactoryGirl.build(:question, title: nil)
    expect(question).to be_invalid
  end

  it 'validates that there is at least one correct answer' do
    question = FactoryGirl.build(:question)
    expect(question).to be_invalid
  end

  it 'last' do
    FactoryGirl.create(:answer)
    question = FactoryGirl.create(:question)
    expect(question).to be_valid
  end
end

