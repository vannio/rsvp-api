require 'rails_helper'

describe Api::V1::RsvpsController, type: :controller do
  let(:json_response) { JSON.parse(response.body) }

  describe '#index' do
    it 'Not authorized to see rsvps if not logged in' do
      event = create(:ceremony)
      get :index, params: { event_id: event.id }
      expect(response.status).to eq(401)
      expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
    end
  end
end
