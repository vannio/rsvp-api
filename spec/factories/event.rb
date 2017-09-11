FactoryGirl.define do
  factory :ceremony, class: Event do
    before(:create) { |event| event.venue = FactoryGirl.create(:church_venue) }
    title "Ceremony"
  end

  factory :church_venue, class: Venue do
    before(:create) { |venue| venue.address = FactoryGirl.create(:church_address) }
    name 'Holy Trinity Church (Hotwells)'
  end

  factory :church_address, class: Address do
    street 'Clifton Vale'
    city 'Bristol'
    postcode 'BS8 4ST'
    country 'United Kingdom'
  end
end
