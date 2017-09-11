require 'rails_helper'

describe Api::V1::EventsController, type: :controller do
  let(:json_response) { JSON.parse(response.body) }

  describe '#index' do
    it 'Lists events without needing authentication' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    context 'Logged in user' do
      it 'cannot update events' do
        sign_in_as_user
        put :update, params: { id: 1 }
        expect(response.status).to eq(401)
        expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
      end
    end

    context 'Logged in admin' do
      it 'can update events' do
        sign_in_as_admin
        event = create(:ceremony)
        put :update, params: {
          id: event.id,
          event: { title: "Hen party" }
        }
        expect(response.status).to eq(200)
        expect(json_response.with_indifferent_access).to include({ title: "Hen party" })
      end
    end
  end

  describe '#destroy' do
    context 'Logged in user' do
      it 'cannot delete events' do
        sign_in_as_user
        delete :destroy, params: { id: 1 }
        expect(response.status).to eq(401)
        expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
      end
    end

    context 'Logged in admin' do
      it 'can delete events' do
        sign_in_as_admin
        event = create(:ceremony)
        delete :destroy, params: { id: event.id }
        expect(response.status).to eq(204)
      end
    end
  end
end
