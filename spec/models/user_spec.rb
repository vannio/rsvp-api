require 'rails_helper'

describe User do
  describe '#new' do
    it 'creates a new user with the right parameters' do
      user = User.new({
        first_name: "Hugh",
        last_name: "Jass",
        email: "hjass@getting.married",
        password: "gettingmarried"
      })
      expect(user.save).to be true
      expect(user.errors.messages).to be_empty
    end

    describe 'does not save user with missing parameter' do
      it 'email' do
        user = User.new({
          first_name: "Hugh",
          last_name: "Jass",
          password: "gettingmarried"
        })
        expect(user.save).to be false
        expect(user.errors.messages).to_not be_empty
        expect(user.errors.messages.first).to include(:email)
      end

      it 'password' do
        user = User.new({
          first_name: "Hugh",
          last_name: "Jass",
          email: "hjass@getting.married"
        })
        expect(user.save).to be false
        expect(user.errors.messages).to_not be_empty
        expect(user.errors.messages.first).to include(:password)
      end

      it 'first_name' do
        user = User.new({
          last_name: "Jass",
          email: "hjass@getting.married",
          password: "gettingmarried"
        })
        expect(user.save).to be false
        expect(user.errors.messages).to_not be_empty
        expect(user.errors.messages.first).to include(:first_name)
      end

      it 'last_name' do
        user = User.new({
          first_name: "Hugh",
          email: "hjass@getting.married",
          password: "gettingmarried"
        })
        expect(user.save).to be false
        expect(user.errors.messages).to_not be_empty
        expect(user.errors.messages.first).to include(:last_name)
      end
    end

    it 'does not save user with a duplicate email address' do
      create(:user)
      user = User.new({
        first_name: "Hugh",
        last_name: "Jass",
        email: "hjass@getting.married",
        password: "gettingmarried"
      })
      expect(user.save).to be false
      expect(user.errors.messages).to_not be_empty
      expect(user.errors.messages.first).to include(:email)
    end
  end
end
