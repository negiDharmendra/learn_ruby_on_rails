require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  let(:blog) { create(:blog) }
  describe 'GET#new' do
    it 'should display the newly created blog' do
    get :new ,{user_id: blog.user_id}
    expect(response).to render_template 'new'
    end
  end
end