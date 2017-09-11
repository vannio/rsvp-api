require 'rails_helper'

describe Api::V1::RsvpsController, type: :controller do
  describe '#index' do
    let(:json_response) { JSON.parse(response.body).with_indifferent_access }
    let(:invalid_response) {
      {
        error: "Not Authorized"
      }
    }

    it 'Not authorized to see rsvps unless logged in' do
      event = create(:ceremony)
      get :index, params: { event_id: event.id }
      expect(response.status).to eq(401)
      expect(json_response).to match(invalid_response)
    end
  end
end
