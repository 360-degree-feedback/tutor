require 'spec_helper'

describe Slide do

  before do
    @slide = FactoryGirl.build(:slide)
  end

  it 'has correct title' do
    expect(@slide.title).to eq('Test slide')
  end

  it 'validates title correctly' do
    slide = FactoryGirl.build(:slide, title: nil)
    expect(slide).to be_invalid
  end

  it 'has correct markdown' do
    expect(@slide.markdown).to eq('#Test')
  end

  it 'validates markdown correctly' do
    slide = FactoryGirl.build(:slide, markdown: nil)
    expect(slide).to be_invalid
  end
end