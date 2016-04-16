FactoryGirl.define do
  factory :user do
    name 'John'
    email 'john_1@gmail.com'
    password 'password'
    password_confirmation 'password'
    activated false
  end
end