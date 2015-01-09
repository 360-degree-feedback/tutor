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
    incorrect = FactoryGirl.create(:incorrect_answer)
    incorrect2 = FactoryGirl.create(:incorrect_answer)
    expect { FactoryGirl.create(:question, answers: [incorrect, incorrect2]) }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Answers must have one correct answer")
  end

  it 'validates true when there is one correct answer and one false' do
    incorrect = FactoryGirl.create(:incorrect_answer)
    correct = FactoryGirl.create(:answer)
    expect { FactoryGirl.create(:question, answers: [incorrect, correct])}.not_to raise_error()
  end

  it 'validates that there is only one correct answer' do
    correct = FactoryGirl.create(:answer)
    correct2 = FactoryGirl.create(:correct_answer)
    expect { FactoryGirl.create(:question, answers: [correct, correct2]) }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Answers must have one correct answer")
  end

  it 'validates that a single incorrect answer is invalid' do
    answer = FactoryGirl.create(:incorrect_answer)
    expect { FactoryGirl.create(:question, answers: Array(answer)) }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Answers must have one correct answer")
  end

  it 'validates that a single correct answer is valid' do
    answer = FactoryGirl.create(:answer)
    expect { FactoryGirl.create(:question, answers: Array(answer)) }.to_not raise_error()
  end
end

