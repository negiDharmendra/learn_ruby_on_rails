require 'rails_helper'


RSpec.describe 'User Signup', type: :request do

  it 'error_explanation/warning  message should be there for invalid signup' do
    user = FactoryGirl.create(:user)
    get '/signup'
    expect(response).to render_template('users/new')
    post '/users', user: {name: 'xyz', email: 'john_1@gmail.com', password: 'password', password_confirmation: 'password'}
    expect(response.body.include?('error_explanation')).to eq(true)
    expect(flash[:success_message].nil?).to eq(true)
    expect(flash[:warning].nil?).to eq(false)
    expect(response).to render_template('users/new')
    expect(response).to have_http_status(200)
    user.destroy
  end
  it 'success and activation message should be there for valid signup' do
    get '/signup'
    expect(response).to render_template('users/new')
    post '/users', user: {name: 'xyz', email: 'new_john_1@gmail.com', password: 'password', password_confirmation: 'password'}
    expect(response.body.include?('error_explanation')).to eq(false)
    expect(response).to redirect_to('http://www.example.com/')
    expect(flash[:success_message].nil?).to eq(false)
    expect(flash[:activation_message].nil?).to eq(false)
    expect(response).to have_http_status(302)
    delete "/users/#{assigns(:user).id}"
  end

  it 'user should not be able to log in with inactive account' do
    get '/signup'
    expect(response).to render_template('users/new')
    post '/users', user: {name: 'xyz', email: 'new_john_1@gmail.com', password: 'password', password_confirmation: 'password'}
    user = assigns(:user)
    expect(response.body.include?('error_explanation')).to eq(false)
    expect(response).to redirect_to('http://www.example.com/')
    expect(flash[:success_message].nil?).to eq(false)
    expect(flash[:activation_message].nil?).to eq(false)
    expect(response).to have_http_status(302)
    get '/login'
    expect(response).to render_template('sessions/new')
    post '/login', session: {email: user.email, password: user.password}
    expect(is_logged_in?).to eq(false)
    delete "/users/#{user.id}"
  end
  it 'user should not be able to log in with inactive account' do

    get '/signup'
    expect(response).to render_template('users/new')
    post '/users', user: {name: 'john_2', email: 'new_john_2@gmail.com', password: 'password', password_confirmation: 'password'}
    user = assigns(:user)
    expect(response.body.include?('error_explanation')).to eq(false)
    expect(response).to redirect_to('http://www.example.com/')
    expect(flash[:success_message].nil?).to eq(false)
    expect(flash[:activation_message].nil?).to eq(false)
    expect(response).to have_http_status(302)
    get edit_account_activation_path(user.activation_token, email: user.email)
    expect(flash[:success_message].nil?).to eq(false)
    expect(response).to redirect_to("http://www.example.com/login")
    get '/login'
    expect(response).to render_template('sessions/new')
    expect(is_logged_in?).to eq(false)
    post '/login', session: {email: user.email, password: user.password}
    p flash.inspect
    expect(response).to redirect_to("http://www.example.com/users/#{user.id}")
    expect(is_logged_in?).to eq(true)
  end
end
