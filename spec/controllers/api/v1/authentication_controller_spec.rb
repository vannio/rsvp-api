require 'rails_helper'

describe Api::V1::AuthenticationController, type: :controller do
  let(:json_response) { JSON.parse(response.body).with_indifferent_access }
  let(:invalid_response) {
    {
      error: {
        user_authentication: ["invalid credentials"]
      }
    }
  }

  describe '#authenticate' do
    it 'Authenticates a user with valid credentials' do
      create(:admin)

      post :authenticate, params: {
        email: 'van@getting.married',
        password: 'gettingmarried'
      }

      expect(json_response).to_not match(invalid_response)
    end

    it 'Does not authenticate a user with invalid credentials' do
      controller do
        params = {
          email: 'van@getting.married',
          password: 'wrongpassword'
        }
      end

      post :authenticate
      expect(json_response).to match(invalid_response)
    end
  end
end
