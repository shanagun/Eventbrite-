# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
user_count = User.all.count
10.times do |f|
User.create!(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name, 
  description: Faker::Quote.famous_last_words, 
  email: "henri#{f+user_count}@yopmail.com", 
  password: 'Helloworld',
  password_confirmation: 'Helloworld'
  )
end
puts "10 utilisateurs crees"


10.times do |index|
Event.create!(
  title: "Event#{index}", 
  description: Faker::ChuckNorris.fact, 
  admin: User.all.sample, 
  location: Faker::Address.full_address, 
  price: rand(1..10)*100, 
  duration: rand(1..10)*5, 
  start_date: Faker::Date.forward(days: 100)
  )
end
puts "10 evenements crees"

10.times do |x|
  Attendance.create(
    user_id: User.all.sample.id,
    event_id: Event.all.sample.id)
end
puts "10 participations crees"