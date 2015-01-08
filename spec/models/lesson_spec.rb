require 'spec_helper'

describe Lesson do

  before do
    @lesson = FactoryGirl.build(:lesson)
  end

  it 'created lesson has valid title' do
    expect(@lesson.title).to eq('Test')
  end

  it 'validates title correctly' do
    lesson = FactoryGirl.build(:lesson, title: nil)
    expect(lesson).to be_invalid
  end

  it 'created lesson has valid description' do
    expect(@lesson.description).to eq('Testing')
  end

  it 'validates description correctly' do
    lesson = FactoryGirl.build(:lesson, description: nil)
    FactoryGirl.build(:lesson, description: nil)
    expect(lesson).to be_invalid
  end
end
