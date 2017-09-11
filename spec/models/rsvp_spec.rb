require 'rails_helper'

describe Rsvp do
  before do
    time_snapshot = Time.now
    @rsvp = described_class.new({
      user: create(:user),
      event: create(:ceremony),
      created_at: time_snapshot,
      updated_at: time_snapshot
    })
  end

  describe '#responded?' do
    it 'returns false if it hasn\'t been updated since being created' do
      expect(@rsvp.responded?).to be false
    end

    it 'return true if it has been updated since being created' do
      @rsvp.updated_at = Time.now
      expect(@rsvp.responded?).to be true
    end
  end

  describe '#responded' do
    it 'is an alias of #responded?' do
      expect(@rsvp.responded).to eq(@rsvp.responded?)
    end
  end
end
