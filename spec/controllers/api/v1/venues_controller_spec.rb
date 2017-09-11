require 'rails_helper'

describe Api::V1::VenuesController, type: :controller do
  let(:event) { create(:ceremony) }
  let(:json_response) { JSON.parse(response.body) }

  describe '#index' do
    it 'Lists venues without needing authentication' do
      get :index, params: { event_id: event.id }
      expect(response.status).to eq(200)
      expect(json_response.length).to eq(1)
    end
  end

  describe '#update' do
    context 'Logged in user' do
      it 'cannot update venues' do
        sign_in_as_user
        put :update, params: { event_id: event.id, id: event.venue.id }
        expect(response.status).to eq(401)
        expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
      end
    end

    context 'Logged in admin' do
      it 'can update venues' do
        sign_in_as_admin
        put :update, params: {
          event_id: event.id,
          id: event.venue.id,
          venue: { name: "Fake venue" }
        }
        expect(response.status).to eq(200)
        expect(json_response.with_indifferent_access).to include({ name: "Fake venue" })
      end
    end
  end

  describe '#destroy' do
    context 'Logged in user' do
      it 'cannot delete events' do
        sign_in_as_user
        delete :destroy, params: { event_id: event.id, id: event.venue.id }
        expect(response.status).to eq(401)
        expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
      end
    end

    context 'Logged in admin' do
      it 'can delete events' do
        sign_in_as_admin
        event = create(:ceremony)
        delete :destroy, params: { event_id: event.id, id: event.venue.id }
        expect(response.status).to eq(204)
      end
    end
  end
end
