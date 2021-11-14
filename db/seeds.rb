# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

merchant_seed = Merchant.create(name: "Unfriendly Traveling Merchant")

discount1_seed = @merchant.discounts.create!(discount_percentage: 20, threshhold_quantity: 10)
discount2_seed = @merchant.discounts.create!(discount_percentage: 15, threshhold_quantity: 8)
discount3_seed = @merchant.discounts.create!(discount_percentage: 10, threshhold_quantity: 5)
