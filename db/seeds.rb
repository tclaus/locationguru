# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Catering Types. Where to get food&bevarage?
CateringType.create([{ name: 'Flexible' },
                    { name: 'Fixed Partner' },
                    { name: 'No Catering' }])

# What do I expect from the location?
KindType.create([{ name: 'Party Location' },
                { name: 'Hotel' },
                { name: 'Restaurant' },
                { name: 'Pub' },
                { name: 'Stadion' },
                { name: 'Multi-Purpose Room' },
                { name: 'Ballroom' },
                { name: 'Tent' },
                { name: 'Castle/Historic' },
                { name: 'Cafe/Bisto' },
                { name: 'Beer Garden' },
                { name: 'Clubhouse' },
                { name: 'Lighthouse' },
                { name: 'Boat/Ship' },
                { name: 'Beachclub' }])

# Where is it? How to get there
LocationType.create([{ name: 'Countryside' },
                    { name: 'City' },
                    { name: 'Coast'}])
