require 'rails_helper'

RSpec.describe VersionsController, type: :controller do
  let(:version) { create(:version) }
  let(:blog) { create(:blog) }
  describe 'GET#index' do
    context 'versions of a blog exist' do
      it 'displays all versions of a blog' do
        get :index, {user_id: version.blog.user_id, blog_id: version.blog_id}
        expect(assigns(:version)).to eq([version])
      end
    end
    context 'versions of a blog do not exist' do
      it 'redirects it to home page' do
        get :index, {user_id: blog.user_id, blog_id: blog.id}
        expect(response).to redirect_to "/users/#{blog.user_id}"
      end
    end
  end


  describe 'GET#show' do
    it 'shows a specific version of a blog' do
      get :show, {user_id: version.blog.user_id, blog_id: version.blog_id, id: version.to_param}
      expect(assigns(:version)).to eq(Version.first)
    end
  end


end
