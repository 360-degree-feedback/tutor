FactoryGirl.define do
  factory :question do
    title 'What is your name?'
    association :lesson, factory: :lesson
  end
end