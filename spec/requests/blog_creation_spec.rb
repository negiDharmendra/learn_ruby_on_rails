require 'rails_helper'

RSpec.describe 'Blog creation', type: :request do
  before(:each) do
    @user = FactoryGirl.create(:user, :activated)
    post '/login', session:{email: @user.email , password: @user.password}
  end

  after(:each) do
    delete '/logout'
    @user.destroy
  end

  it 'should respond with an error for empty title or content of a blog' do
    expect(response).to redirect_to("http://www.example.com/users/#{@user.id}")
    get new_user_blog_path(@user)
    expect(response).to render_template('blogs/new')
    post user_blogs_path, blog:{title: '', content: 'some text ...'}
    expect(response.body.include? 'error_explanation').to eq(true)
    expect(response).to render_template('blogs/new')
    post user_blogs_path, blog:{title: 'Some text', content: ''}
    expect(response.body.include? 'error_explanation').to eq(true)
    expect(response).to render_template('blogs/new')
  end

  it 'should be successful for valid information' do
    expect(response).to redirect_to("http://www.example.com/users/#{@user.id}")
    get new_user_blog_path(@user)
    expect(response).to render_template('blogs/new')
    post user_blogs_path, blog:{title: 'Some text', content: 'some text ...'}
    expect(response.body.include? 'error_explanation').to eq(false)
    expect(response).to redirect_to("http://www.example.com/users/#{@user.id}")
  end

end
