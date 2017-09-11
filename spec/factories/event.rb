FactoryGirl.define do
  factory :ceremony, class: Event do
    title "Ceremony"
    before(:create) do |event|
      event.venue = FactoryGirl.create(:church_venue)
    end
  end

  factory :church_venue, class: Venue do
    name 'Holy Trinity Church (Hotwells)'
    before(:create) do |venue|
      venue.address = FactoryGirl.create(:church_address)
    end
  end

  factory :church_address, class: Address do
    street 'Clifton Vale'
    city 'Bristol'
    postcode 'BS8 4ST'
    country 'United Kingdom'
  end
end
