require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  let(:json_response) { JSON.parse(response.body) }

  describe '#index' do
    it 'Not authorized to see users if not logged in' do
      get :index
      expect(response.status).to eq(401)
      expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
    end

    context 'Logged in user' do
      it 'cannot see the list of users' do
        sign_in_as_user
        get :index
        expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
        expect(response.status).to eq(401)
      end
    end

    context 'Logged in admin' do
      it 'can see the list of users' do
        sign_in_as_admin
        get :index
        expect(response.status).to eq(200)
        expect(json_response.length).to eq(1)
      end
    end
  end

  describe '#show' do
    context 'Logged in user' do
      before { sign_in_as_user }

      it 'can view their own details' do
        get :show, params: { id: @current_user.id }
        expect(response.status).to eq(200)
      end

      it 'cannot view another user\'s details' do
        user = create(:user2)
        get :show, params: { id: user.id }
        expect(response.status).to eq(401)
        expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
      end
    end

    context 'Logged in admin' do
      it 'can see any user\'s details' do
        sign_in_as_admin
        get :show, params: { id: create(:user) }
        expect(response.status).to eq(200)
        expect(json_response.with_indifferent_access).to include({
          first_name: "Hugh",
          last_name: "Jass",
          email: "hjass@getting.married"
        })
      end
    end
  end

  describe '#create' do
    it 'Not authorized to create a user if not logged in' do
      post :create
      expect(response.status).to eq(401)
      expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
    end

    context 'Logged in admin' do
      it 'can create another user' do
        sign_in_as_admin
        post :create, params: {
          user: {
            first_name: "Seymour",
            last_name: "Butts",
            email: "s.b@getting.married",
            password: "gettingmarried"
          }
        }
        expect(response.status).to eq(201)
      end
    end
  end

  describe '#update' do
    it 'Not authorized to update a user if not logged in' do
      put :update, params: { id: 1 }
      expect(response.status).to eq(401)
      expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
    end

    context 'Logged in user' do
      before { sign_in_as_user }

      it 'can update their own details' do
        put :update, params: {
          id: @current_user.id,
          user: {
            first_name: "Seymour",
            last_name: "Butts"
          }
        }
        expect(response.status).to eq(200)
        expect(json_response.with_indifferent_access).to include({
          first_name: "Seymour",
          last_name: "Butts"
        })
      end

      it 'cannot update another user\'s details' do
        user = create(:user2)
        put :update, params: { id: user.id }
        expect(response.status).to eq(401)
        expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
      end
    end

    context 'Logged in admin' do
      it 'can update another user' do
        sign_in_as_admin
        user = create(:user)
        put :update, params: {
          id: user.id,
          user: {
            first_name: "Seymour",
            last_name: "Butts"
          }
        }
        expect(response.status).to eq(200)
        expect(json_response.with_indifferent_access).to include({
          first_name: "Seymour",
          last_name: "Butts"
        })
      end
    end
  end

  describe '#destroy' do
    it 'Not authorized to delete a user if not logged in' do
      delete :destroy, params: { id: 1 }
      expect(response.status).to eq(401)
      expect(json_response.with_indifferent_access).to match({ error: "Not Authorized" })
    end

    context 'Logged in admin' do
      it 'can delete another user' do
        sign_in_as_admin
        user = create(:user)
        delete :destroy, params: { id: user.id }
        expect(response.status).to eq(204)
      end
    end
  end
end
