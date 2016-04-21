require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
  let(:user) { create(:user) }
  describe 'GET#edit' do
    context "when activation link is valid" do
      it 'should activate the account' do
        expect(user.activated).to eq(false)
        get :edit, id: user.activation_token, email: user.email
        expect(flash[:success_message].nil?).to eq(false)
        expect(response).to redirect_to '/login'
      end
    end
    context "when activation link is invalid" do
      it 'should throw an error and redirect to root page' do
        get :edit, id: 'invalid_id', email: user.email
        expect(flash[:danger].nil?).to eq(false)
        expect(response).to redirect_to root_url

      end

    end
  end
end
