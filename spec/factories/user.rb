FactoryGirl.define do
  factory :user do
    name 'John'
    email 'john_1@gmail.com'
    password 'password'
    password_confirmation 'password'
    activated false

    trait :activated do
      activated true
    end
  end

end