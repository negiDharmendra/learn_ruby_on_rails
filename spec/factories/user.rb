FactoryGirl.define do
    factory :user do
        name 'John'
        email 'john_1@gmail.com'
        password  'password'
        password_confirmation 'password'
    end
end