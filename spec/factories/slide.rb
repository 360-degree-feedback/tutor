FactoryGirl.define do
  factory :slide do
    title 'Test slide'
    association :lesson, factory: :lesson
  end
end