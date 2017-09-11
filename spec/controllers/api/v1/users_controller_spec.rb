require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  describe '#index' do
    let(:json_response) { JSON.parse(response.body).with_indifferent_access }
    let(:invalid_response) {
      {
        error: "Not Authorized"
      }
    }

    it 'Not authorized to see users unless logged in' do
      user = create(:user)
      get :index
      expect(response.status).to eq(401)
      expect(json_response).to match(invalid_response)
    end
  end
end
