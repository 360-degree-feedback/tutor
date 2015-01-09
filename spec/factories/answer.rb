FactoryGirl.define do
  factory :answer, class: Answer do
    title 'Steve'
    correct true
  end
  factory :correct_answer, class: Answer do
    title 'Andrew'
    correct true
  end

  factory :incorrect_answer, class: Answer do
    title 'John'
    correct false
  end

end