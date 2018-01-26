# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{ full_name: 'Gregory Skovoroda', location: 'Europe' },
                     { full_name: 'Henry David Thoreau', location: 'North America' }])

items = Item.create([{ name: 'Ax', price: 120.5 },
                     { name: 'Bag', price: 80.0 },
                     { name: 'Spade', price: 135.0 },
                     { name: 'Sopilka', price: 53.0 },
                     { name: 'Bible', price: 200.0 },
                     { name: 'Boots', price: 105.3 }])
