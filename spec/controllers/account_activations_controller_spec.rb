require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
  let(:user) { create(:user) }
  describe 'GET#edit' do
    it 'should activate the account' do
      expect(user.activated).to eq(false)
      get :edit, id: user.activation_token, email: user.email
      expect(flash[:success_message].nil?).to eq(false)
      expect(response).to redirect_to '/login'

    end
  end
end
