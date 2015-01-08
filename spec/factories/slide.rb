FactoryGirl.define do
  factory :slide do
    title 'Test slide'
    markdown '#Test'
    association :lesson, factory: :lesson
  end
end