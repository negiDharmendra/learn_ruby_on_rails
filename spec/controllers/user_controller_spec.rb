require 'rails_helper'

RSpec.describe UsersController, type: :request do
    it 'should routes the user to login page if user is not loggedin' do
        get '/users'
        expect(response).to redirect_to('/login')
    end

    it 'should not allow user to get all users' do
        user = FactoryGirl.create(:user)
        post '/login', session:{email: 'john_1@gmail.com',password: 'password',}
        get '/users'
        expect(response).to redirect_to('/login')
    end
end
