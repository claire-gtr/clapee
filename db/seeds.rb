puts "Destroy all"
Review.destroy_all
Event.destroy_all
User.destroy_all

puts "Creating event"
Rake::Task['digitick:fetch'].invoke
puts "Events created"
