require 'rails_helper'


RSpec.describe 'Reset password', type: :request do
  it 'should work for valid reset token' do
    user = FactoryGirl.create(:user, :activated)
    get '/reset_passwords/new'
    expect(response).to render_template('reset_passwords/new')
    post '/reset_passwords',reset_password: {email: user.email}
    expect(flash[:success_message].nil?).to eq(false)
    user.generate_reset_password_token
    get edit_reset_passwords_path(reset_password_token: user.reset_password_token, email: user.email)
    expect(response).not_to have_http_status(302)
    expect(response).to have_http_status(200)
    post edit_reset_passwords_path(reset_password:{email: user.email,password: '12345678',new_password_confirmation: '12345678'})
    expect(response).to redirect_to("http://www.example.com/users/#{user.id}")
    delete '/logout'
    expect(response).to redirect_to('http://www.example.com/')
    get '/login'
    expect(response).to render_template('sessions/new')
    post '/login', session: {email: user.email, password: '12345678'}
    expect(response).to redirect_to("http://www.example.com/users/#{user.id}")
    delete "/users/#{user.id}"
  end
  it 'should not work for invalid reset token' do
    user = FactoryGirl.create(:user, :activated)
    get '/reset_passwords/new'
    expect(response).to render_template('reset_passwords/new')
    post '/reset_passwords',reset_password: {email: user.email}
    expect(flash[:success_message].nil?).to eq(false)
    user.generate_reset_password_token
    get edit_reset_passwords_path(reset_password_token: user.reset_password_token+'Sdsrf', email: user.email)
    expect(response).to have_http_status(302)
    expect(response).not_to have_http_status(200)
    expect(response).to redirect_to("http://www.example.com/login")
    delete "/users/#{user.id}"
  end
end
