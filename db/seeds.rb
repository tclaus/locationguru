# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Catering Types. Where to get food&bevarage?
CateringType.delete_all
KindType.delete_all
LocationType.delete_all
Translation.delete_all

CateringType.create([{ id: 1,
                       name: 'Flexible' },
                     { id: 2,
                       name: 'Fixed Partner' },
                     { id: 3,
                       name: 'No Catering' },
                       {id: 4,
                         name: 'In-house'}])

# What do I expect from the location?
KindType.create([{ id: 1,
                   name: 'Party Location' },
                 { id: 2,
                   name: 'Hotel' },
                 { id: 3,
                   name: 'Restaurant' },
                 { id: 4,
                   name: 'Pub' },
                 { id: 5,
                   name: 'Stadion' },
                 { id: 6,
                   name: 'Multi-Purpose Room' },
                 { id: 7,
                   name: 'Ballroom' },
                 { id: 8,
                   name: 'Tent' },
                 { id: 9,
                   name: 'Castle/Historic' },
                 { id: 10,
                   name: 'Cafe/Bisto' },
                 { id: 11,
                   name: 'Beer Garden' },
                 { id: 12,
                   name: 'Clubhouse' },
                 { id: 13,
                   name: 'Lighthouse' },
                 { id: 14,
                   name: 'Boat/Ship' },
                 { id: 15,
                   name: 'Beachclub' },
                 { id: 16,
                   name: 'country house' },
                 { id: 17,
                   name: 'warehouse' },
                 { id: 18,
                   name: 'industry' }])

# Where is it? How to get there
LocationType.create([{ id: 1,
                       name: 'Countryside' },
                     { id: 2,
                       name: 'City' },
                     { id: 3,
                       name: 'Coast' },
                     { id: 4,
                       name: 'Mountains' }])

# Translations:
# DE
Translation.create([{ category: 'CateringType',
                      text_id: 1,
                      language_id: 'de',
                      translation: 'Flexibel' },
                    { category: 'CateringType',
                      text_id: 2,
                      language_id: 'de',
                      translation: 'Fester Partner' },
                    { category: 'CateringType',
                      text_id: 3,
                      language_id: 'de',
                      translation: 'Kein Catering/ Selbst organisieren' },
                      { category: 'CateringType',
                        text_id: 4,
                        language_id: 'de',
                        translation: 'Kann gestellt werden' },
                    { category: 'KindType',
                      text_id: 1,
                      language_id: 'de',
                      translation: 'Party Location' },
                    { category: 'KindType',
                      text_id: 2,
                      language_id: 'de',
                      translation: 'Hotel' },
                    { category: 'KindType',
                      text_id: 3,
                      language_id: 'de',
                      translation: 'Restaurant' },
                    { category: 'KindType',
                      text_id: 4,
                      language_id: 'de',
                      translation: 'Gaststätte' },
                    { category: 'KindType',
                      text_id: 5,
                      language_id: 'de',
                      translation: 'Stadion' },
                    { category: 'KindType',
                      text_id: 6,
                      language_id: 'de',
                      translation: 'Mehrzweckraum' },
                    { category: 'KindType',
                      text_id: 7,
                      language_id: 'de',
                      translation: 'Ballsaal' },
                    { category: 'KindType',
                      text_id: 8,
                      language_id: 'de',
                      translation: 'Zelt' },
                    { category: 'KindType',
                      text_id: 9,
                      language_id: 'de',
                      translation: 'Schloss/Burg' },
                    { category: 'KindType',
                      text_id: 10,
                      language_id: 'de',
                      translation: 'Cafel/Bistro' },
                    { category: 'KindType',
                      text_id: 11,
                      language_id: 'de',
                      translation: 'Biergarten' },
                    { category: 'KindType',
                      text_id: 12,
                      language_id: 'de',
                      translation: 'Vereinshaus' },
                    { category: 'KindType',
                      text_id: 13,
                      language_id: 'de',
                      translation: 'Leuchtturm' },
                    { category: 'KindType',
                      text_id: 14,
                      language_id: 'de',
                      translation: 'Hausboot/Schiff' },
                    { category: 'KindType',
                      text_id: 15,
                      language_id: 'de',
                      translation: 'Strandhaus' },
                    { category: 'KindType',
                      text_id: 16,
                      language_id: 'de',
                      translation: 'Landhaus' },
                    { category: 'KindType',
                      text_id: 17,
                      language_id: 'de',
                      translation: 'Lagehalle' },
                    { category: 'KindType',
                      text_id: 18,
                      language_id: 'de',
                      translation: 'Industrie' },
                    { category: 'LocationType',
                      text_id: 1,
                      language_id: 'de',
                      translation: 'Außerhalb d. Stadt' },
                    { category: 'LocationType',
                      text_id: 2,
                      language_id: 'de',
                      translation: 'Stadt' },
                    { category: 'LocationType',
                      text_id: 3,
                      language_id: 'de',
                      translation: 'Küste' },
                    { category: 'LocationType',
                      text_id: 4,
                      language_id: 'de',
                      translation: 'Berge' }])

# EN
Translation.create([{ category: 'CateringType',
                      text_id: 1,
                      language_id: 'en',
                      translation: 'Flexible' },
                    { category: 'CateringType',
                      text_id: 2,
                      language_id: 'en',
                      translation: 'Fixed Partner' },
                    { category: 'CateringType',
                      text_id: 3,
                      language_id: 'en',
                      translation: 'No catering / Self organized' },
                      { category: 'CateringType',
                        text_id: 4,
                        language_id: 'de',
                        translation: 'On Site' },
                    { category: 'KindType',
                      text_id: 1,
                      language_id: 'en',
                      translation: 'Party venue' },
                    { category: 'KindType',
                      text_id: 2,
                      language_id: 'en',
                      translation: 'Hotel' },
                    { category: 'KindType',
                      text_id: 3,
                      language_id: 'en',
                      translation: 'Restaurant' },
                    { category: 'KindType',
                      text_id: 4,
                      language_id: 'en',
                      translation: 'Pub' },
                    { category: 'KindType',
                      text_id: 5,
                      language_id: 'en',
                      translation: 'Stadion' },
                    { category: 'KindType',
                      text_id: 6,
                      language_id: 'en',
                      translation: 'Multi-purpose room' },
                    { category: 'KindType',
                      text_id: 7,
                      language_id: 'en',
                      translation: 'Ballroom' },
                    { category: 'KindType',
                      text_id: 8,
                      language_id: 'en',
                      translation: 'Tent' },
                    { category: 'KindType',
                      text_id: 9,
                      language_id: 'en',
                      translation: 'Castle' },
                    { category: 'KindType',
                      text_id: 10,
                      language_id: 'en',
                      translation: 'Cafe' },
                    { category: 'KindType',
                      text_id: 11,
                      language_id: 'en',
                      translation: 'Beergarden' },
                    { category: 'KindType',
                      text_id: 12,
                      language_id: 'en',
                      translation: 'Clubhouse' },
                    { category: 'KindType',
                      text_id: 13,
                      language_id: 'en',
                      translation: 'Lighthouse' },
                    { category: 'KindType',
                      text_id: 14,
                      language_id: 'en',
                      translation: 'Houseboat/Ship' },
                    { category: 'KindType',
                      text_id: 15,
                      language_id: 'en',
                      translation: 'Beachhouse' },
                    { category: 'KindType',
                      text_id: 16,
                      language_id: 'en',
                      translation: 'Countryhouse' },
                    { category: 'KindType',
                      text_id: 17,
                      language_id: 'en',
                      translation: 'Warehouse' },
                    { category: 'KindType',
                      text_id: 18,
                      language_id: 'en',
                      translation: 'Industry' },
                    { category: 'LocationType',
                      text_id: 1,
                      language_id: 'en',
                      translation: 'Countryside' },
                    { category: 'LocationType',
                      text_id: 2,
                      language_id: 'en',
                      translation: 'City' },
                    { category: 'LocationType',
                      text_id: 3,
                      language_id: 'en',
                      translation: 'Coast' },
                    { category: 'LocationType',
                      text_id: 4,
                      language_id: 'en',
                      translation: 'Mountains' }])
