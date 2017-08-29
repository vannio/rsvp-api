addresses = Address.create([
  {
    street: 'Clifton Vale',
    city: 'Bristol',
    postcode: 'BS8 4ST',
    country: 'United Kingdom'
  },
  {
    street: 'Narrow Lewins Mead',
    city: 'Bristol',
    postcode: 'BS1 2NN',
    country: 'United Kingdom'
  },
  {
    street: 'Seven Sisters Road',
    city: 'London',
    postcode: 'N4',
    country: 'United Kingdom'
  }
])

venues = Venue.create([
  {
    name: 'Holy Trinity Church (Hotwells)',
    url: 'http://www.holytrinityhotwells.org',
    address: addresses[0]
  },
  {
    name: 'The Emmanuel Meeting House',
    url: 'https://emmanuelbristol.org.uk',
    address: addresses[1]
  }
])

events = Event.create([
  {
    title: 'Ceremony',
    datetime: '2018-07-01T14:00',
    venue: venues[0]
  },
  {
    title: 'Reception',
    datetime: '2018-07-01T17:00',
    venue: venues[1]
  }
])

users = User.create([
  {
    first_name: 'Van',
    last_name: 'Le',
    email: 'van@getting.married',
    max_party_size: 2,
    address: addresses[2],
    password: 'gettingmarried',
    password_confirmation: 'gettingmarried'
  },
  {
    first_name: 'Sarah',
    last_name: 'Simmons',
    email: 'sl.simmons@getting.married',
    max_party_size: 2,
    password: 'gettingmarried',
    password_confirmation: 'gettingmarried'
  },
  {
    first_name: 'John',
    last_name: 'Smith',
    email: 'johnsmith@email.com',
    password: 'gettingmarried',
    password_confirmation: 'gettingmarried'
  },
  {
    first_name: 'Jane',
    last_name: 'Smith',
    email: 'janesmith@email.com',
    password: 'gettingmarried',
    password_confirmation: 'gettingmarried'
  }
])

rsvps = Rsvp.create([
  {
    user: users[0],
    event: events[0]
  },
  {
    user: users[0],
    event: events[1]
  },
  {
    user: users[1],
    event: events[0]
  },
  {
    user: users[1],
    event: events[1]
  },
  {
    user: users[2],
    event: events[1]
  },
  {
    user: users[3],
    event: events[1]
  }
])
