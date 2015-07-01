puts "Seeding user..."
User.create(email: 'gamer@test.com', password: '1234567890', gamertag: "tehbeast", region: "US", language: "EN", mic: true, auth_token: Devise.friendly_token)
puts "Done"


puts "Seeding Destiny..."
@destiny = Game.create(name: 'Destiny')
@destiny_events = ['Crucible', 'Strike Playlist', 'Vault of Glass', 'Vault of Glass (h)', 'Crotas End', 'Crotas End (h)', 'Prison of Elders (32)', 'Prison of Elders (34)', 'Prison of Elders (35)', 'Trials of Osiris', 'Trials of Osiris (Flawless)']

@destiny_events.each do |event|
  new_event = @destiny.events.create(name: event, group_size: 6)
  10.times { new_event.posts.create(title: FFaker::Lorem.phrase, checkpoint: FFaker::Lorem.word, user_id: User.first.id) }
end
puts "Done"


puts "Seeding Bloodborne..."
@bloodborne = Game.create(name: 'Bloodborne')
@bloodborne_events = ['Cleric Beast', 'Father Gascoigne', 'Vicar Amelia', 'Blood-Starved Beast', 'The Witch of Hemwick', 'Darkbeast Paarl', 'Shadow of Yharnam', 'Rom The Vacuous Spider', 'The One Reborn', 'Micolash, Host of the Nightmare', 'Mergo\'s Wet Nurse', 'Martyr Logarius', 'Amygdala', 'Celestial Emissary', 'Ebrietas, Daughter of the Cosmos', 'Gehrman, the First Hunter', 'Moon Presence']

@bloodborne_events.each do |event|
  new_event = @bloodborne.events.create(name: event, group_size: 6)
  10.times { new_event.posts.create(title: FFaker::Lorem.phrase, checkpoint: FFaker::Lorem.word, user_id: User.first.id) }
end
puts "Done"


