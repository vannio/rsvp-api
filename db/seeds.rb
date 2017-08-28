# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

addresses = [
  {
    id: 1,
    street: 'Clifton Vale',
    city: 'Bristol',
    postcode: 'BS8 4ST',
    country: 'United Kingdom'
  },
  {
    id: 2,
    street: 'Narrow Lewins Mead',
    city: 'Bristol',
    postcode: 'BS1 2NN',
    country: 'United Kingdom'
  },
  {
    id: 3,
    street: 'Seven Sisters Road',
    city: 'London',
    postcode: 'N4',
    country: 'United Kingdom'
  }
]

Address.create(addresses)

venues = [
  {
    id: 1,
    name: 'Holy Trinity Church (Hotwells)',
    url: 'http://www.holytrinityhotwells.org',
    address_id: 1
  },
  {
    id: 2,
    name: 'The Emmanuel Meeting House',
    url: 'https://emmanuelbristol.org.uk',
    address_id: 2
  }
]

Venue.create(venues)

events = [
  {
    id: 1,
    title: 'Ceremony',
    date: 'Mon, 29 May 2017',
    time: '2000-01-01 13:00:00 UTC',
    venue_id: 1
  },
  {
    id: 2,
    title: 'Reception',
    date: 'Mon, 29 May 2017',
    time: '2000-01-01 16:00:00 UTC',
    venue_id: 2
  }
]

Event.create(events)

users = [
  {
    first_name: 'Van',
    last_name: 'Le',
    email: 'van@getting.married',
    party_size: 2,
    password: 'gettingmarried',
    password_confirmation: 'gettingmarried',
    admin: true,
    address_id: 3
  },
  {
    first_name: 'Sarah',
    last_name: 'Simmons',
    email: 'sl.simmons@getting.married',
    party_size: 2,
    password: 'gettingmarried',
    password_confirmation: 'gettingmarried',
    admin: true
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
]

User.create(users)

rsvps = [
  {
    user_id: 1,
    event_id: 1
  },
  {
    user_id: 1,
    event_id: 2
  },
  {
    user_id: 2,
    event_id: 1
  },
  {
    user_id: 2,
    event_id: 2
  },
  {
    user_id: 3,
    event_id: 2
  },
  {
    user_id: 4,
    event_id: 2
  }
]

Rsvp.create(rsvps)
