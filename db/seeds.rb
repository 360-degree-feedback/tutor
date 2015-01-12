# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



User.create!(email: 'administrator@prodigyfinance.com', password: 'pfadmin', password_confirmation: 'pfadmin', name: 'Admin', surname: 'Administrator', admin: true, activation_state: 'active')

puts 'Seeds successfully loaded into db.rails'
