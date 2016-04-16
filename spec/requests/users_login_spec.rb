require 'rails_helper'

RSpec.describe 'UsersLogins', type: :request do

  it 'flash message regarding danger should present for empty email' do
    get '/login'
    expect(response).to render_template('sessions/new')
    post '/login', session: {email: '', password: 'foobar'}
    expect(response).to render_template('sessions/new')
    expect(flash.empty?).to eq(false)
    expect(response.body.include? 'Invalid email/password combination').to eq(true)
    expect(response).to have_http_status(200)
  end
  it 'flash message regarding danger should present for empty password' do
    get '/login'
    expect(response).to render_template('sessions/new')
    post '/login', session: {email: 'xyz@gmail.com', password: ''}
    expect(response).to render_template('sessions/new')
    expect(flash.empty?).to eq(false)
    expect(response.body.include? 'Invalid email/password combination').to eq(true)
    expect(response).to have_http_status(200)
  end

  it 'flash message regarding danger should not present for successful login' do
    user = FactoryGirl.create(:user)
    get edit_account_activation_path(user.activation_token,email: user.email)
    delete '/logout'
    expect(response).to redirect_to('/')
    get '/login'
    expect(response).to render_template('sessions/new')
    post '/login', session: {email: user.email, password: user.password}
    expect(flash.empty?).to eq(true)
    expect(response.body.include? 'Invalid email/password combination').to eq(false)
    expect(response).to have_http_status(302)
  end

  it 'login with remember_me option' do
    user = FactoryGirl.create(:user)
    get edit_account_activation_path(user.activation_token,email: user.email)
    get '/login'
    post '/login', session: {email: user.email, password: user.password, remember_me: 1}
    expect(cookies['remember_token'].nil?).to eq(false)
  end

  it 'login without remember_me option' do
    user = FactoryGirl.create(:user)
    get '/login'
    post '/login', session: {email: user.email, password: user.password, remember_me: 0}
    expect(cookies['remember_token'].nil?).to eq(true)
  end
end
