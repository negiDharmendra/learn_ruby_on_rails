require 'rails_helper'

RSpec.describe VersionsController, type: :controller do
  let(:version) { create(:version) }
  describe 'GET#index'
   context 'versions of a blog exist' do
     it 'displays all versions of a blog' do
       get :index, {user_id: version.blog.user_id, blog_id: version.blog_id}
       expect(assigns(:version)).to eq([version])
     end

   end


end
