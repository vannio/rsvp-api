require 'rails_helper'

describe Api::V1::VenuesController, type: :controller do
  describe '#index' do
    let(:json_response) { JSON.parse(response.body).map{ |r| r.with_indifferent_access } }

    it 'finds all the listed event venues' do
      event = create(:ceremony)
      event.venue = create(:church_venue)

      get :index, params: { event_id: event.id }

      expect(response.status).to eq(200)
      expect(json_response.length).to eq(1)
    end
  end
end
