require 'rails_helper'

describe Api::V1::EventsController, type: :controller do
  describe '#index' do
    it 'finds all the listed events' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
