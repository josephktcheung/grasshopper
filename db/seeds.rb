# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Apprenticeship.destroy_all
Rating.destroy_all
Skill.destroy_all
Proficiency.destroy_all
Conversation.destroy_all

def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}.jpg"))
end

about_cm = 'Master of everything, including web development.'
about_gh = 'Information about me will go here.'
about_ms = 'Information about me will go here.'
about_my = %{
  The Grand Master of the Jedi Council, I have trained Jedi for over 800 years.
  My small size causes many to underestimate me.
  I prefer meditation and reflection, spending much time pondering the mysteries of the Force.
  I have witnessed the decay of the Galactic Republic,
  and saw the Jedi Order transform from peacekeepers to battlefield commanders in the Clone Wars.
  When I must, I wield my lightsaber and becomes a whirling warrior of great speed and agility.
  A stern instructor, I nonetheless have a mischievous sense of humor.
  With the rise of the Galactic Empire, I fled into exile and awaited
  the arrival of a new Jedi student to rekindle a new hope in the galaxy.
  }.squish
about_ls = %{
  Raised as a farmboy on the backwater desert world of Tatooine,
  I had no idea that I was the secret son of Anakin Skywalker.
  After my stepparents were murdered by the Empire,
  I destroyed the Death Star and became the Rebellion's greatest hero.
  But my true destiny lay with the Jedi Order.
  I learned the ways of the Force from Obi-Wan Kenobi and Yoda,
  and discovered the terrible secret of my parentage.
  I insisted there was still good in Darth Vader, and my love for father reawakened Anakin's spirit,
  inspiring my dad to sacrifice himself to destroy Darth Sidious. lol.
  }.squish
about_dm = %{
  I began life as one of the Nightbrothers on Dathomir.
  Darth Sidious brutally trained me to be a weapon of the Sith as well as a scheming mastermind.
  A relentless and acrobatic warrior with an extremely dangerous double-ended lightsaber,
  I longed for revenge against the Jedi, to destroy the Order and restore power to the Sith.
  Defeated at the Battle of Naboo,
  I disappeared from the galaxy for over a decade before reemerging as a new threat during the Clone Wars.
  }.squish
about_ds = %{
  I was the last chancellor of the Old Republic,
  and the mastermind behind the biggest power-grab in galactic history.
  Practicing forbidden Sith techniques under my alternate identity of Darth Sidious,
  I arranged for my public persona to deflect suspicion while receiving praise and political respect.
  In time I moved from a senator representing Naboo to the Republic's Supreme Chancellor,
  and used the power of my office to launch the Clone Wars.
  With Order 66 bringing about the end of the Jedi Order, I declared myself Emperor.
  }.squish
about_wc = %{
  Wayne Campbell owns a public access cable show called Wayne's World.
  He still lives with his parents and has an extensive collections of nametags and hairnets.
  Waynes best friend is Garth Algar and his girlfriend is Cassandra, lead singer of the band Cruical Taunt.
  He is portrayed by Mike Myers. He gatecrashes Cassandra and Bobby's arranged marriage
  and him and Cassandra leave the chapel in a school bus.
  He arranges a concert in Aurora, once being visited by Jim Morrison in a dream.
  }.squish
about_ga = %{
  Wayne's best friend is Garth Algar. He gets very nervous without Wayne.
  He appears to have a fear of heights.
  }.squish
about_tl = %{
  Ted Theodore Logan, III (also known as Ted) was, along with his friend Bill,
  co-founder and guitarist of the rock-group Wyld Stallyns.
  After an excellent adventure through time and a bogus journey through the afterlife,
  Bill & Ted's Wyld Stallyns eventually became known as the greatest rock-group to have ever lived,
  and their music became the basis of all society, inspiring universal harmony.
  }.squish
about_bp = %{
  William S. Preston, Esq. (Also known as Bill) was, along with his friend Ted,
  co-founder and guitarist of the rock-group Wyld Stallyns.
  After an excellent adventure through time and a bogus journey through the afterlife,
  Bill & Ted's Wyld Stallyns eventually became known as the greatest rock-group to have ever lived,
  and their music became the basis of all society, inspiring universal harmony.
  }.squish
about_hy = %{
  A rat mutated by exposure to toxic ooze,
  Splinter raised the Teenage Mutant Ninja Turtles and trained them in the art of ninjutsu.
  He is also the mortal enemy of Shredder.
  He is a father figure to the turtles and is easily able to fight them all at once.
  He does not carry a signature weapon however he is well known to walk around with a wooden cane
  and also seems to be a incredible marksman with the bow and arrow.
  }.squish
about_lh = %{
  Leonardo is the calm, focused, and disciplined leader of his brothers, the Teenage Mutant Ninja Turtles.
  Nicknamed "Leo," he is usually seen with a blue mask and twin swords.
  }.squish

cm = User.create(first_name: 'Charles', last_name: 'Munat', email: 'chasm@ga.co', password: '123', password_confirmation: '123', role: 'master', about_me: about_cm, avatar: seed_image('munat'))
gh = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'apprentice', about_me: about_gh, avatar: seed_image('default-grasshopper'))

ms = User.create(first_name: 'Master', last_name: 'Shifu', email: 'ms@kp.movie', password: '123', password_confirmation: '123', role: 'master', about_me: about_ms, avatar: seed_image('default-master'))

my = User.create(first_name: 'Master', last_name: 'Yoda', email: 'my@jedi.sw', password: '123', password_confirmation: '123', role: 'master', avatar: seed_image('yoda'), about_me: about_my)
ls = User.create(first_name: 'Luke', last_name: 'Skywalker', email: 'ls@jedi.sw', password: '123', password_confirmation: '123', role: 'apprentice', avatar: seed_image('luke'), about_me: about_ls)

dm = User.create(first_name: 'Darth', last_name: 'Maul', email: 'dm@sith.sw', password: '123', password_confirmation: '123', role: 'apprentice', avatar: seed_image('darth_maul'), about_me: about_dm)
ds = User.create(first_name: 'Darth', last_name: 'Sidious', email: 'ds@sith.sw', password: '123', password_confirmation: '123', role: 'master', avatar: seed_image('darth_sidious'), about_me: about_ds)

wc = User.create(first_name: 'Wayne', last_name: 'Campbell', email: 'wc@partyon.co', password: '123', password_confirmation: '123', role: 'master', avatar: seed_image('wayne'), about_me: about_wc)
ga = User.create(first_name: 'Garth', last_name: 'Algar', email: 'ga@partyon.co', password: '123', password_confirmation: '123', role: 'apprentice', avatar: seed_image('garth'), about_me: about_ga)

tl = User.create(first_name: 'Ted', last_name: 'Logan', email: 'tl@excellent.co', password: '123', password_confirmation: '123', role: 'master', avatar: seed_image('ted'), about_me: about_tl)
bp = User.create(first_name: 'Bill', last_name: 'Preston', email: 'bp@excellent.co', password: '123', password_confirmation: '123', role: 'apprentice', avatar: seed_image('bill'), about_me: about_bp)

hy = User.create(first_name: 'Hamato', last_name: 'Yoshi', email: 'hy@cowabunga.co', password: '123', password_confirmation: '123', role: 'master', avatar: seed_image('splinter'), about_me: about_hy)
lh = User.create(first_name: 'Leonardo', last_name: 'Hamato', email: 'lh@cowabunga.co', password: '123', password_confirmation: '123', role: 'apprentice', avatar: seed_image('leonardo'), about_me: about_lh)


a1 = Apprenticeship.create(master: cm, apprentice: gh, end_date: (1.month.from_now))
a2 = Apprenticeship.create(master: ds, apprentice: dm, end_date: (20.year.from_now))

a3 = Apprenticeship.create(master: hy, apprentice: lh, end_date: (20.year.from_now))

Rating.create(rater: gh, ratee: ms, apprenticeship: a2, rating: 5)
Rating.create(rater: ms, ratee: gh, apprenticeship: a1, rating: 3)

Rating.create(rater: hy, ratee: lh, apprenticeship: a3, rating: 5)
Rating.create(rater: lh, ratee: hy, apprenticeship: a3, rating: 5)

# Rating.create(rater: , ratee: , apprenticeship: , rating: )
skills = ['Ruby on Rails', 'Javascript', 'CSS', 'Bartending', 'Jedi', 'Sith', 'Pascal', 'Kung Fu', 'Ninjitsu', 'Cable TV', 'Rocking Out', 'Time Travel']

skills.each { |skill| Skill.create(skill_name: skill) }

skills = Skill.all

Proficiency.create!(user: cm, skill: skills[0], proficiency_status: 'has')
Proficiency.create!(user: cm, skill: skills[1], proficiency_status: 'has')
Proficiency.create!(user: cm, skill: skills[2], proficiency_status: 'has')
Proficiency.create!(user: cm, skill: skills[3], proficiency_status: 'has')

Proficiency.create!(user: gh, skill: skills[0], proficiency_status: 'desired')
Proficiency.create!(user: gh, skill: skills[1], proficiency_status: 'desired')
Proficiency.create!(user: gh, skill: skills[2], proficiency_status: 'desired')

Proficiency.create!(user: ms, skill: skills[7], proficiency_status: 'has')

Proficiency.create!(user: my, skill: skills[4], proficiency_status: 'has')
Proficiency.create!(user: ls, skill: skills[4], proficiency_status: 'has')

Proficiency.create!(user: dm, skill: skills[5], proficiency_status: 'desired')
Proficiency.create!(user: ds, skill: skills[5], proficiency_status: 'desired')

Proficiency.create!(user: wc, skill: skills[9], proficiency_status: 'has')
Proficiency.create!(user: ga, skill: skills[9], proficiency_status: 'has')

Proficiency.create!(user: tl, skill: skills[10], proficiency_status: 'has')
Proficiency.create!(user: bp, skill: skills[10], proficiency_status: 'has')

Proficiency.create!(user: tl, skill: skills[11], proficiency_status: 'desired')
Proficiency.create!(user: bp, skill: skills[11], proficiency_status: 'desired')

Proficiency.create!(user: hy, skill: skills[8], proficiency_status: 'has')
Proficiency.create!(user: hy, skill: skills[7], proficiency_status: 'has')
Proficiency.create!(user: lh, skill: skills[8], proficiency_status: 'has')

Proficiency.create!(user: lh, skill: skills[7], proficiency_status: 'desired')

# Proficiency.create!(user: , skill: skills[], proficiency_status: 'has')
# Proficiency.create!(user: , skill: skills[], proficiency_status: 'desired')

c1 = Conversation.create!(created_by: gh, created_for: ms)

<<<<<<< HEAD
Message.create!(conversation: c1, recipient: ms, sender: gh, content: 'Hello, I hope to work with you!')
Message.create!(conversation: c1, recipient: gh, sender: ms, content: 'Sure, let me know when you want to meet up!')
=======
c2 = Conversation.create!(created_by: bp, created_for: tl)

Message.create!(conversation: c1, recipient: gh, sender: ms, content: 'Hello, I hope to work with you!')
Message.create!(conversation: c1, recipient: ms, sender: gh, content: 'Sure, let me know when you want to meet up!')
>>>>>>> e1e406817c50f4c19e7d97373804df1949059b9f

Message.create!(conversation: c2, recipient: tl, sender: bp, content: 'Dude?')
Message.create!(conversation: c2, recipient: bp, sender: tl, content: 'Dude!')



