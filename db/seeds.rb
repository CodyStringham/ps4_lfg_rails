puts "Seeding user..."
User.create(email: 'gamer@test.com', password: '1234567890', gamertag: "tehbeast" )
puts "Done"


puts "Seeding Destiny..."
@destiny = Game.create(name: 'Destiny')
@destiny_events = ['Vault of Glass', 'Vault of Glass (h)', 'Crotas End', 'Crotas End (h)']

@destiny_events.each do |event|
  new_event = @destiny.events.create(name: event, group_size: 6)
  10.times { new_event.posts.create(title: FFaker::Lorem.phrase, checkpoint: FFaker::Lorem.word, user_id: User.first.id) }
end
puts "Done"


puts "Seeding Bloodborne..."
@bloodborne = Game.create(name: 'Bloodborne')
@bloodborne_events = ['Cleric Beast', 'Father Gascoigne', 'Vicar Amelia', 'Blood-Starved Beast']

@bloodborne_events.each do |event|
  new_event = @bloodborne.events.create(name: event, group_size: 6)
  10.times { new_event.posts.create(title: FFaker::Lorem.phrase, checkpoint: FFaker::Lorem.word, user_id: User.first.id) }
end
puts "Done"


