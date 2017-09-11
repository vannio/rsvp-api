require 'rails_helper'

describe Api::V1::AuthenticationController, type: :controller do
  let(:json_response) { JSON.parse(response.body).with_indifferent_access }

  describe '#authenticate' do
    it 'Authenticates a user with valid credentials' do
      create(:admin)
      post :authenticate, params: {
        email: 'ipfreely@getting.married',
        password: 'gettingmarried'
      }
      expect(json_response).to_not match({ error: { user_authentication: ["invalid credentials"] } })
    end

    it 'Does not authenticate a user with invalid credentials' do
      post :authenticate
      expect(json_response).to match({ error: { user_authentication: ["invalid credentials"] } })
    end
  end
end
