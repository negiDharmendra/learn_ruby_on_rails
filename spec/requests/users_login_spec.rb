require 'rails_helper'

RSpec.describe 'UsersLogins', type: :request do

    it 'flash message regarding danger should present for empty email' do
        get '/login'
        expect(response).to render_template('sessions/new')
        post '/login', session: {email: '', password: 'foobar'}
        expect(response).to render_template('sessions/new')
        expect(flash.empty?).to eq(false)
        expect(response).to have_http_status(200)
    end
    it 'flash message regarding danger should present for empty password' do
        get '/login'
        expect(response).to render_template('sessions/new')
        post '/login', session: {email: 'xyz@gmail.com', password: ''}
        expect(response).to render_template('sessions/new')
        expect(flash.empty?).to eq(false)
        expect(response).to have_http_status(200)
    end

    it 'flash message regarding danger should not present for successful login' do
        get '/signup'
        user = FactoryGirl.create(:user)
        get '/login'
        expect(response).to render_template('sessions/new')
        post '/login', session: {email: 'john@gmail.com', password: 'password'}
        expect(response).to have_http_status(302)
    end
end
