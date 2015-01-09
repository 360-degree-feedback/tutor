FactoryGirl.define do
  factory :user do
    email 'harry@potter.com'
    name 'Harry'
    surname 'Potter'
    salt 'asdasdastr4325234324sdfds'
    crypted_password 'secret'
    activation_state 'active'
  end

  factory :admin, class: User do
    email 'admin@admin.com'
    name 'admin'
    surname 'admin'
    admin true
    salt 'asdasdastr4325234324sdfds'
    crypted_password 'secret'
    activation_state 'active'
  end
end
