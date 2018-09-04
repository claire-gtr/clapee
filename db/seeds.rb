# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Creating event"
rihanna = Event.create(title: "Rihanna World Tour", location_name: "Stade de France", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat magni beatae ea natus quis, officiis inventore blanditiis temporibus facere, accusamus deserunt ad repellat dolorem nemo quisquam. Cum ad, commodi voluptatum.")
beyonce = Event.create(title: "Beyonce & Jay Z", location_name: "Girls Power", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat magni beatae ea natus quis, officiis inventore blanditiis temporibus facere, accusamus deserunt ad repellat dolorem nemo quisquam. Cum ad, commodi voluptatum.")
puts "Events created"
