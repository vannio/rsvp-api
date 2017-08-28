# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

addresses = [
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
  }
]

Address.create(addresses)

venues = [
  {
    name: 'Holy Trinity Church (Hotwells)',
    url: 'http://www.holytrinityhotwells.org',
    address: Address.first
  },
  {
    name: 'The Emmanuel Meeting House',
    url: 'https://emmanuelbristol.org.uk',
    address: Address.last
  }
]

Venue.create(venues)

events = [
  {
    title: 'Ceremony',
    date: 'Mon, 29 May 2017',
    time: '2000-01-01 13:00:00 UTC',
    venue: Venue.first
  },
  {
    title: 'Reception',
    date: 'Mon, 29 May 2017',
    time: '2000-01-01 16:00:00 UTC',
    venue: Venue.last
  }
]

Event.create(events)
