require 'rails_helper'

RSpec.describe 'User Signup', type: :request do

    it 'error message should be there for invalid signup' do
        user  =  FactoryGirl.create(:user)
        get '/signup'
        expect(response).to render_template('users/new')
        post '/users', user: {name: 'xyz',email: 'john_1@gmail.com',password: 'password',password_confirmation: 'password'}
        expect(response.body.include?('error_explanation')).to eq(true)
        expect(response).to render_template('users/new')
        expect(response).to have_http_status(200)
    end
    it 'error message should be there for invalid signup' do
        get '/signup'
        expect(response).to render_template('users/new')
        post '/users', user: {name: 'xyz',email: 'new_john_1@gmail.com',password: 'password',password_confirmation: 'password'}
        expect(response.body.include?('error_explanation')).to eq(false)
        expect(response).to have_http_status(302)
    end
end
